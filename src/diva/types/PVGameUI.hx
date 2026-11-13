package diva.types;

import cpp.Reference;
import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;

@:include('diva_types.h')
@:native('PVGameUI')
@:structAccess
extern class PVGameUI {
    // Array, length is 95
    @:native('aet_list') var aetList:RawPointer<Int32>;
    // Array, length is 95
    @:native('visibility') var visibility:RawPointer<Bool>;
    // Array, length is 2
    @:native('frame_bottom_offset') var frameBottomOffset:RawPointer<Float32>;
    // Array, length is 2
    @:native('frame_bottom_dt') var frameBottomDt:RawPointer<Float32>;
    // Array, length is 2
    @:native('frame_top_offset') var frameTopOffset:RawPointer<Float32>;
    // Array, length is 2
    @:native('frame_top_dt') var frameTopDt:RawPointer<Float32>;
    // Array, length is 2
    @:native('bottom_offset') var bottomOffset:RawPointer<Float32>;
    // Array, length is 2
    @:native('top_offset') var topOffset:RawPointer<Float32>;
    // Array, length is 2
    @:native('frame_visibility') var frameVisibility:RawPointer<Bool>;
    // Array, length is 2
    @:native('frame_action') var frameAction:RawPointer<Int32>;
    @:native('life') var life:Int32;
    @:native('draw_combo_counter') var drawComboCounter:Bool;
    @:native('chance_txt_state') var chanceTxtState:Int32;
    @:native('show_chance_txt') var showChanceTxt:Bool;
    @:native('combo_counter_state') var comboCounterState:Int32;
    @:native('combo_counter_time') var comboCounterTime:Float32;
    @:native('combo_num') var comboNum:Int32;
    @:native('combo_counter_pos') var comboCounterPos:Reference<Vec2>;
}