import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class FiltersStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final bool openMenuFilter;
  final List<DataModel?> filterSubcategory;
  final List<DataModel?> filterZone;
  final List<DataModel?> filterCategory;
  final List<DataModel> itemsFilter;
  final List<DataModel> placesFilter;
  final String section;

  FiltersStatus({required this.isLoading, required this.openMenu, required this.openMenuTab, required this.openMenuFilter,
    required this.filterSubcategory, required this.filterZone, required this.filterCategory,required this.itemsFilter,
    required this.placesFilter, required this.section
  });

  FiltersStatus copyWith({
    bool? isLoading, bool? openMenu, bool? openMenuTab, bool? openMenuFilter,
    List<DataModel?>? filterSubcategory, List<DataModel?>? filterZone, List<DataModel?>? filterCategory,
    List<DataModel>? itemsFilter, List<DataModel>? placesFilter, String? section
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
      section: section ?? this.section
    );
  }
}
