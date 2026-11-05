package diva.types;

import cpp.SizeT;
import cpp.UInt64;
import cpp.RawPointer;
import cpp.Int32;

@:include('diva_types.h')
@:native('PVGamePvData')
@:structAccess
extern class PVGamePvData {
    @:native('dsc_state') var dscState:Int32;
    @:native('play') var play:Bool;
    // Array, length is 45000
    @:native('script_buffer') var scriptBuffer:RawPointer<Int>;
    @:native('script_pos') var scriptPos:Int;
    @:native('script_time') var scriptTime:UInt64;
    @:native('has_dsc_signature') var hasDscSignature:Bool;
    @:native('is_dsc_ac200_format') var isDscAC200Format:Bool;
    @:native('targets_remaining') var targetsRemaining:Int;
    @:native('target_index') var targetIndex:SizeT;
    @:native('dsc_branch_mode') var dscBranchMode:Int32;
    @:native('first_challenge_target_index') var firstChallengeTargetIndex:Int32;
    @:native('last_challenge_target_index') var lastChallengeTargetIndex:Int32;

    @:native('::TargetCount') public static function getTargetCount(d:PVGamePvData):SizeT;
    @:native('::TargetAt') public static function getTargetAt(d:PVGamePvData, i:SizeT):PvDscTargetGroup;
    @:native('::PvDataGame') public static function getPvGame(d:PVGamePvData):PVGameData;
}