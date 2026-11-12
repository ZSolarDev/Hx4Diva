package diva.types.menu;

import cpp.Int32;
import cpp.RawPointer;
import cpp.UInt8;
import diva.types.menu.sort.*;
import diva.types.prj.PrjVector;

@:include('diva_types.h')
@:native('PVSelectorSwitch')
@:structAccess
extern class PVSelectorSwitch {
	@:native('state') var state:Int32;
	@:native('is_ranking_mode') var isRankingMode:Bool;
	@:native('sel_pv_list') var selPvList:SelPvList;
	// prj::vector<pvsel::PvData> sorted_pv_lists[32];
	@:native('sorted_pv_lists') var sortedPvLists:RawPointer<PrjVector<PvData>>;
	@:native('cur_pv_list') var curPvList:RawPointer<PrjVector<PvData>>;
	@:native('random_pv') var randomPv:PvData;

	/**
	 * The index into the current sort mode. Use in combination with
	 * `sortMode`.
	 *
	 * @since 1.0.0-alpha.1
	 */
	@:native('cur_sort_index') var curSortIndex:RawPointer<SortIndex>;

	// int32_t song_counts[21];
	@:native('song_counts') var songCounts:RawPointer<Int32>;

	/**
	 * The current sort mode's `All` index.
	 *
	 * @since 1.0.0-alpha.1
	 */
	@:native('all_sort_index') var allSortIndex:AllSortIndices;

	/**
	 * The current PV's ID.
	 * 
	 * @since 1.0.0-alpha.1
	 */
	@:native('pv_id') var pvId:Int32;

	// int32_t sort_indices[4];
	@:native('sort_indices') var sortIndices:RawPointer<Int32>;
	@:native('sort_change_dir') var sortChangeDir:Int32;

	/**
	 * The current sort mode.
	 *
	 * @since 1.0.0-alpha.1
	 */
	@:native('sort_mode') var sortMode:SortMode;

	@:native('difficulty_min') var difficultyMin:UInt8;
	@:native('difficulty_max') var difficultyMax:UInt8;
	@:native('difficulty') var difficulty:Int32;
	@:native('edition') var edition:Int32;
}
