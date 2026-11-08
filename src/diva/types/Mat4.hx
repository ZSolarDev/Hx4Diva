package diva.types;

@:include('diva_types.h')
@:native('::diva::mat4')
@:structAccess
extern class Mat4 {
	var row0:Vec4;
	var row1:Vec4;
	var row2:Vec4;
	var row3:Vec4;

	@:native('GetScale') function getScale():Vec3;
	function new(row0:Vec4, row1:Vec4, row2:Vec4, row3:Vec4);
}
