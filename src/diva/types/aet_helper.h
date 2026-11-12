#pragma once

#include <utility>
#include <optional>
#include <functional>
#include <string_view>
#include "diva_types.h"

enum AnchorMode : int32_t
{
	AnchorMode_Left    = 0,
	AnchorMode_Right   = 1,
	AnchorMode_Top     = 2,
	AnchorMode_Bottom  = 3,
	AnchorMode_Center  = 4,
};

class AetElement
{
public:
	AetElement() = default;
	AetElement(uint32_t scene_id) : scene_id(scene_id) { }

	AetElement(AetElement&& other) noexcept
	{
		scene_id = other.scene_id;
		handle = other.handle;
		args = other.args;
		layer_name = other.layer_name;
		other.handle = 0;
	}

	~AetElement() { DeleteHandle(); }

	inline void SetScene(uint32_t id) { scene_id = id; }
	bool SetLayer(std::string name, int32_t flags, int32_t prio, int32_t res_mode, std::string_view start_marker, std::string_view end_marker, const diva::vec3* pos);
	bool SetLayer(std::string name, int32_t prio, int32_t res_mode, int32_t action);

	bool GetLayout(std::string layer_name, AetLayout& layout) const;

    void SetScale(const diva::vec3& scale);
	void SetPosition(const diva::vec3& pos);
	void SetOpacity(float opacity);
	void SetLoop(bool loop);
	void SetVisible(bool visible);
	void SetColor(int32_t color);
	void SetMarkers(const std::string& start_marker, const std::string& end_marker);
	void SetMarkers(const std::string& start_marker, const std::string& end_marker, bool loop);

	inline uint32_t GetSceneID() { return scene_id; }
	inline const AetArgs& GetArgs() { return args; }
	inline bool Ended() const { return aet::GetEnded(handle); }
	inline bool IsPlaying() const { return handle != 0; }

	bool DrawSpriteAt(std::string layer_name, uint32_t id, int32_t prio = 1) const;
private:
	uint32_t scene_id = 0;
	AetHandle handle = 0;
	AetArgs args = { };
	std::string layer_name;

	void DeleteHandle();
	void Remake();
};

std::pair<int32_t, int32_t> GetLayerAxisAnchor(std::string_view layer_name);
int32_t GetLayerSpriteAnchor(std::string_view layer_name);

// NOTE: Returns the position adjusted to it's anchor suffix (ex: _c, _rt).
//       To be used for positioning text / sprites;
//       Do *not* use rotation on layers you intend to use as layout!
diva::vec2 GetLayoutAdjustedPosition(const AetLayout& layout, std::string_view layer_name);

void DrawSpriteAtLayout(const AetLayout& layout, std::string_view layer_name, uint32_t sprite_id, int32_t prio, int32_t res, bool adjust_pos = false);

std::string GetLanguageSuffix();
std::string GetCurrentPlatformSuffix();
uint32_t FindSpriteID(std::string_view name);
uint32_t FindSpriteIDWithLocale(std::string_view base_name);