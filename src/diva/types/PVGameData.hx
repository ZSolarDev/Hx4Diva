package diva.types;

import cpp.Float32;
import cpp.Int32;
import cpp.Int64;
import cpp.RawPointer;
import cpp.Reference;
import diva.types.prj.PrjVector;

@:include('diva_types.h')
@:native('PVGameData')
@:structAccess
extern class PVGameData {
	@:native('loaded') var loaded:Bool;
	@:native('pv_data') var pvData:Reference<PVGamePvData>;
	@:native('ui') var gameUI:Reference<PVGameUI>;
	@:native('life') var life:Int32;
	@:native('score') var score:Int32;
	@:native('scoring_enabled') var scoringEnabled:Bool;
	@:native('total_challenge_bonus') var totalChallengeBonus:Int32;
	@:native('combo') var combo:Int32;
	@:native('total_surv_challenge_bonus') var totalSurvChallengeBonus:Int32;
	@:native('challenge_combo') var challengeCombo:Int32;
	@:native('max_combo') var maxCombo:Int32;
	// Array, length is 5
	@:native('judge_count') var judgeCount:RawPointer<Int32>;
	// Array, length is 5
	@:native('judge_count_correct') var judgeCountCorrect:RawPointer<Int32>;
	@:native('challenge_bonus') var challengeBonus:Int32;
	@:native('reference_score') var referenceScore:Int32;
	@:native('reference_score_with_life') var referenceScoreWithLife:Int32;
	@:native('target_reference_scores') var targetReferenceScores:Reference<PrjVector<Int32>>;
	@:native('percentage') var percentage:Float32;
	@:native('challenge_time_start') var challengeTimeStart:Int64;
	@:native('challenge_time_end') var challengeTimeEnd:Int64;
	@:native('pv_end_time') var pvEndTime:Int64;
	@:native('pv_end_time_sec') var pvEndTimeSeconds:Float32;
	@:native('has_success_note') var hasSuccessNote:Bool;
	@:native('current_frame') var currentFrame:Int32;
	@:native('total_life_bonus') var totalLifeBonus:Int32;
	@:native('is_success_branch') var isSuccessBranch:Bool;
}
