import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FiltersStatus extends ViewStatus{

  final bool isLoading;
  bool openMenu;
  bool openMenuTab;
  bool openMenuFilter;
  final List<DataModel?> filterSubcategory;
  final List<DataModel?> filterZone;
  final List<DataModel?> filterCategory;
  final List<DataModel> itemsFilter;
  final List<DataModel> placesFilter;
  final String section;
  final String type;
  final List<StaggeredTile> staggedList;
  final bool shouldPop = true;
  Map oldFilters;

  FiltersStatus({required this.type,required this.isLoading, required this.openMenu, required this.openMenuTab, required this.openMenuFilter,
    required this.filterSubcategory, required this.filterZone, required this.filterCategory,required this.itemsFilter,
    required this.placesFilter, required this.section, required this.staggedList, required this.oldFilters
  });

  FiltersStatus copyWith({String? type,
    bool? isLoading, bool? openMenu, bool? openMenuTab, bool? openMenuFilter,
    List<DataModel?>? filterSubcategory, List<DataModel?>? filterZone, List<DataModel?>? filterCategory,
    List<DataModel>? itemsFilter, List<DataModel>? placesFilter, String? section, List<StaggeredTile>? staggedList, oldFilters,
  }){
    return FiltersStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      openMenuFilter: openMenuFilter ?? this.openMenuFilter,
      filterSubcategory: filterSubcategory ?? this.filterSubcategory,
      filterZone: filterZone ?? this.filterZone,
      filterCategory: filterCategory ?? this.filterCategory,
      itemsFilter: itemsFilter ?? this.itemsFilter,
      placesFilter: placesFilter ??  this.placesFilter,
      section: section ?? this.section,
      type: type ?? this.type,
      staggedList: staggedList ?? this.staggedList,
      oldFilters: oldFilters ?? this.oldFilters 
    );
  }
}
