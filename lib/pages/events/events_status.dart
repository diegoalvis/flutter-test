import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class EventsStatus extends ViewStatus {
  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final String title;
  final String section;
  final String nameFilter;
  final int currentOption;
  final List<DataModel> places;
  final List<DataModel> categories;
  final List<DataModel> subcategories;
  late List<DataModel> zones;


  EventsStatus({
    required this.section,
    required this.isLoading,
    required this.openMenu,
    required this.openMenuTab,
    required this.title,
    required this.nameFilter,
    this.currentOption = -1,
    required this.places,
    required this.categories,
    required this.subcategories,
    required this.zones,
  });

  EventsStatus copyWith({
    int? currentOption,
    String? section,
    bool? isLoading,
    bool? openMenu,
    bool? openMenuTab,
    String? title,
    String? nameFilter,

    List<DataModel>? places,
    List<DataModel>? categories,
    List<DataModel>? subcategories,
    List<DataModel>? zones,
  }) {
    return EventsStatus(
      currentOption: currentOption ?? this.currentOption,
      section: section ?? this.section,
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      title: title ?? this.title,
      nameFilter: nameFilter ?? this.nameFilter,
      places: places ?? this.places,
      categories: categories ?? this.categories,
      subcategories: subcategories ?? this.subcategories,
      zones: zones ?? this.zones,
    );
  }
}
