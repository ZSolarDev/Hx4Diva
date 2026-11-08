#include "hxcpp.h"
#include <initializer_list>
#include <cmath>
#include <cstring>
#include <cctype>
#include "aet_helper.h"

// Replacements for util.h
namespace
{
	bool StartsWith(std::string_view s, std::string_view prefix)
	{
		return s.size() >= prefix.size() && s.substr(0, prefix.size()) == prefix;
	}

	bool EndsWith(std::string_view s, std::string_view suffix)
	{
		return s.size() >= suffix.size() && s.substr(s.size() - suffix.size()) == suffix;
	}

	std::string ToUpper(std::string s)
	{
		for (char& c : s)
			c = static_cast<char>(std::toupper(static_cast<unsigned char>(c)));
		return s;
	}

	// 0xAABBGGRR: floats in x(R), y(G), z(B), w(A) order
	void ColorToFloats(uint32_t color, float* out)
	{
		out[0] = (color & 0xFF) / 255.0f;
		out[1] = ((color >> 8) & 0xFF) / 255.0f;
		out[2] = ((color >> 16) & 0xFF) / 255.0f;
		out[3] = ((color >> 24) & 0xFF) / 255.0f;
	}
}

bool AetElement::SetLayer(std::string name, int32_t flags, int32_t prio, int32_t res_mode, std::string_view start_marker, std::string_view end_marker, const diva::vec3* pos)
{
	layer_name = name;

	args = { };
	args.scene_id = scene_id;
	args.layer_name = layer_name.c_str();
	args.start_marker = start_marker;
	args.end_marker = end_marker;
	args.flags = flags;
	args.index = 0;
	args.layer = 0;
	args.prio = prio;
	args.res_mode = res_mode;
	args.pos = (pos != nullptr) ? *pos : diva::vec3();

	handle = aet::Play(&args, handle);
	return handle != 0;
}

bool AetElement::SetLayer(std::string name, int32_t prio, int32_t res_mode, int32_t action)
{
	layer_name = name;
	args = AetArgs(scene_id, layer_name.c_str(), prio, action);
	args.res_mode = res_mode;
	handle = aet::Play(&args, handle);
	return handle != 0;
}

bool AetElement::GetLayout(std::string layer_name, AetLayout& layout) const
{
    return aet::GetLayout(handle, layer_name.c_str(), &layout);
}

void AetElement::SetPosition(const diva::vec3& pos)
{
	args.pos = pos;
	aet::SetPosition(handle, &pos);
}

void AetElement::SetOpacity(float opacity)
{
	args.color.w = opacity;
	aet::SetOpacity(handle, opacity);
}

void AetElement::SetLoop(bool loop)
{
	int32_t flags = args.flags & ~0x30000;
	args.flags = flags | (loop ? 0x10000 : 0x20000);
}

void AetElement::SetVisible(bool visible)
{
	int32_t flags = args.flags & ~0x8;
	args.flags = flags | (!visible ? 0x8 : 0x0);
	aet::SetVisible(handle, visible);
}

void AetElement::SetColor(int32_t color)
{
	float rgba[4];
	ColorToFloats(static_cast<uint32_t>(color), rgba);
	args.color.x = rgba[0];
	args.color.y = rgba[1];
	args.color.z = rgba[2];
	args.color.w = rgba[3];
	Remake();
}

void AetElement::SetMarkers(const std::string& start_marker, const std::string& end_marker)
{
	args.start_marker = start_marker.c_str();
	args.end_marker = end_marker.c_str();
	handle = aet::Play(&args, handle);
}

void AetElement::SetMarkers(const std::string& start_marker, const std::string& end_marker, bool loop)
{
	SetLoop(loop);
	SetMarkers(start_marker, end_marker);
}

bool AetElement::DrawSpriteAt(std::string layer_name, uint32_t sprite_id, int32_t prio) const
{
	AetLayout layout;
	if (!GetLayout(layer_name, layout))
		return false;

	DrawSpriteAtLayout(layout, layer_name, sprite_id, args.prio + prio, args.res_mode, false);
	return true;
}

void AetElement::DeleteHandle()
{
	aet::Stop(&handle);
}

void AetElement::Remake()
{
	float frame = handle != 0 ? aet::GetFrame(handle) : 0.0f;
	handle = aet::Play(&args, handle);
	aet::SetFrame(handle, frame);
}

// ---- Layout / anchor helpers ----
std::pair<int32_t, int32_t> GetLayerAxisAnchor(std::string_view layer_name)
{
	int32_t x = AnchorMode_Left;
	int32_t y = AnchorMode_Top;

	if (StartsWith(layer_name, "p_"))
	{
		if      (EndsWith(layer_name, "_c"))  { x = AnchorMode_Center; y = AnchorMode_Center; }
		else if (EndsWith(layer_name, "_rt")) { x = AnchorMode_Right;  y = AnchorMode_Top; }
		else if (EndsWith(layer_name, "_ct")) { x = AnchorMode_Center; y = AnchorMode_Top; }
		else if (EndsWith(layer_name, "_lc")) { x = AnchorMode_Left;   y = AnchorMode_Center; }
		else if (EndsWith(layer_name, "_rc")) { x = AnchorMode_Right;  y = AnchorMode_Center; }
		else if (EndsWith(layer_name, "_lb")) { x = AnchorMode_Left;   y = AnchorMode_Bottom; }
		else if (EndsWith(layer_name, "_cb")) { x = AnchorMode_Center; y = AnchorMode_Bottom; }
		else if (EndsWith(layer_name, "_rb")) { x = AnchorMode_Right;  y = AnchorMode_Bottom; }
	}

	return std::make_pair(x, y);
}

int32_t GetLayerSpriteAnchor(std::string_view layer_name)
{
	auto axis = GetLayerAxisAnchor(layer_name);

	if      (axis.first == AnchorMode_Left   && axis.second == AnchorMode_Top)    return 0x40000;
	else if (axis.first == AnchorMode_Left   && axis.second == AnchorMode_Center) return 0x200000;
	else if (axis.first == AnchorMode_Left   && axis.second == AnchorMode_Bottom) return 0x1000000;
	else if (axis.first == AnchorMode_Center && axis.second == AnchorMode_Center) return 0x400000;
	else if (axis.first == AnchorMode_Center && axis.second == AnchorMode_Top)    return 0x80000;
	else if (axis.first == AnchorMode_Center && axis.second == AnchorMode_Bottom) return 0x2000000;
	else if (axis.first == AnchorMode_Right  && axis.second == AnchorMode_Top)    return 0x100000;
	else if (axis.first == AnchorMode_Right  && axis.second == AnchorMode_Center) return 0x800000;
	else if (axis.first == AnchorMode_Right  && axis.second == AnchorMode_Bottom) return 0x4000000;

	return 0x40000;
}

diva::vec2 GetLayoutAdjustedPosition(const AetLayout& layout, std::string_view layer_name)
{
	auto calculateOffset = [](float size, int32_t anchor)
	{
		if (anchor == AnchorMode_Left || anchor == AnchorMode_Top)
			return 0.0f;
		else if (anchor == AnchorMode_Right || anchor == AnchorMode_Bottom)
			return size;
		return size / 2.0f;
	};

	// NOTE: Calculate top-left position
	diva::vec2 scale = { layout.matrix.row0.x, layout.matrix.row1.y };
	diva::vec2 pos = layout.position.xy() - layout.anchor.xy() * scale;

	// NOTE: Add offset to position
	auto axis = GetLayerAxisAnchor(layer_name);
	pos.x += calculateOffset(layout.width * scale.x, axis.first);
	pos.y += calculateOffset(layout.height * scale.y, axis.second);

	return pos;
}

void DrawSpriteAtLayout(const AetLayout& layout, std::string_view layer_name, uint32_t sprite_id, int32_t prio, int32_t res, bool adjust_pos)
{
	SprArgs args;
	args.id = sprite_id;
	args.attr = GetLayerSpriteAnchor(layer_name);
	args.trans = adjust_pos ? diva::vec3(GetLayoutAdjustedPosition(layout, layer_name), 0.0f) : layout.position;
	args.scale = { layout.matrix.row0.x, layout.matrix.row1.y, 1.0f };
	memset(args.color, 0xFF, 4);
	args.color[3] = static_cast<uint8_t>(fminf(layout.opacity * 255.0f, 255.0f));
	args.resolution_mode_screen = res;
	args.resolution_mode_sprite = res;
	args.priority = prio;
	spr::DrawSprite(&args);
}

std::string GetLanguageSuffix()
{
	const char* suffixes[GameLocale_Max] = { "_jp", "_en", "_zh", "_tw", "_kr", "_fr", "_it", "_de", "_sp" };
	int32_t locale = GetGameLocale();
	if (locale < 0 || locale >= GameLocale_Max)
		return "_en";
	return suffixes[locale];
}

std::string GetCurrentPlatformSuffix()
{
	int32_t index = diva::GetInputState(0)->GetDevice();
	if (index < 0 || index > 4)
		return "";

	const char* suffixes[5] = { "_xb", "_ps", "_sw", "_st", "_pc" };
	return suffixes[index];
}

uint32_t FindSpriteID(std::string_view name)
{
	uint32_t* ptr = spr::GetSpriteId(nullptr, name);
	if (!ptr || *ptr == 0xFFFFFFFF)
		return 0;
	return *ptr;
}

uint32_t FindSpriteIDWithLocale(std::string_view base_name)
{
	std::string name = std::string(base_name) + ToUpper(GetLanguageSuffix());
	uint32_t* ptr = spr::GetSpriteId(nullptr, name);

	if (!ptr || *ptr == 0xFFFFFFFF)
		return 0;
	return *ptr;
}