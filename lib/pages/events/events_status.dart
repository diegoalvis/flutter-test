import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class EventsStatus extends ViewStatus {
  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final String title;
  final String nameFilter;
  late List<DataModel> itemsPlaces;
  late List<DataModel> itemsZones;

  EventsStatus({
    required this.isLoading,
    required this.openMenu,
    required this.openMenuTab,
    required this.itemsPlaces,
    required this.title,
    required this.nameFilter,
    required this.itemsZones,
  });

  EventsStatus copyWith({
    bool? isLoading,
    bool? openMenu,
    bool? openMenuTab,
    List<DataModel>? itemsPlaces,
    List<DataModel>? itemsZones,
    String? title,
    String? nameFilter,

  }) {
    return EventsStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      itemsPlaces: itemsPlaces ?? this.itemsPlaces,
      itemsZones: itemsZones ?? this.itemsZones,
      title: title ?? this.title,
      nameFilter: nameFilter ?? this.nameFilter,
    );
  }
}
