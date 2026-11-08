package diva.types.menu;

import cpp.Int32;

@:include('diva_types.h')
@:native('::pvsel::PvData2')
@:structAccess
extern class PvData2 {
	@:native('pv_db_entry') var pvDbEntry:Int32;
	@:native('name_sort_index') var nameSortIndex:Int32;
}
