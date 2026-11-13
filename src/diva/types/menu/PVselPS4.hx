package diva.types.menu;

import cpp.Reference;
import cpp.Float32;
import cpp.Int32;
import cpp.RawPointer;
import diva.types.prj.PrjVector;

@:include('diva_types.h')
@:native('PVselPS4')
@:structAccess
extern class PVselPS4 {
	@:native('state') var state:Int32;
	@:native('cmn_menu') var commonMenu:Reference<CommonMenu>;
	@:native('sel_pv_list') var selPvList:Reference<SelPvList>;
	// prj::vector<PvDataPS4> sorted_pv_lists[32];
	@:native('sorted_pv_lists') var sortedPvLists:RawPointer<PrjVector<PvDataPS4>>;
	@:native('cur_pv_list') var curPvList:RawPointer<PrjVector<PvDataPS4>>;
	@:native('random_pv') var randomPv:Reference<PvDataPS4>;
	// int32_t song_counts[21];
	@:native('song_counts') var songCounts:RawPointer<Int32>;
	@:native('all_sort_index') var allSortIndex:Int32;
	@:native('cur_sort_index') var curSortIndex:RawPointer<Int32>;
	@:native('pv_id') var pvId:Int32;
	@:native('sort_mode') var sortMode:Int32;
	@:native('difficulty') var difficulty:Int32;
	@:native('edition') var edition:Int32;
}
