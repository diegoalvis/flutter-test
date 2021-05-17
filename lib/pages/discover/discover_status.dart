import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class DiscoverStatus extends ViewStatus {
  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final List<DataModel> listOptions;
  final String section;
  final int currentOption;
  final List<DataModel> places;
  final List<DataModel> categories;
  final List<DataModel> subcategories;
  final List<DataModel> zones;

  DiscoverStatus(
      {required this.categories,
      required this.subcategories,
      required this.zones,
      required this.places,
      required this.isLoading,
      required this.openMenu,
      required this.openMenuTab,
      required this.listOptions,
      required this.section,
      this.currentOption = -1});

  DiscoverStatus copyWith(
      {bool? isLoading,
      bool? openMenu,
      bool? openMenuTab,
      bool? isZone,
      List<DataModel>? listOptions,
      List<DataModel>? places,
      List<DataModel>? categories,
      List<DataModel>? subcategories,
      List<DataModel>? zones,
      String? section,
      int? currentOption}) {
    return DiscoverStatus(
      places: places ?? this.places,
      categories: categories ?? this.categories,
      subcategories: subcategories ?? this.subcategories,
      zones: zones ?? this.zones,
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      listOptions: listOptions ?? this.listOptions,
      section: section ?? this.section,
      currentOption: currentOption ?? this.currentOption,
    );
  }
}
