import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class EventsStatus extends ViewStatus {
  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  late List<DataModel> itemsEventPlaces;
  late List<DataModel> itemsSleepPlaces;

  EventsStatus(
      {required this.isLoading,
      required this.openMenu,
      required this.openMenuTab,
      required this.itemsEventPlaces,
      required this.itemsSleepPlaces});

  EventsStatus copyWith(
      {bool? isLoading,
      bool? openMenu,
      bool? openMenuTab,
      List<DataModel>? itemsEventPlaces,
      List<DataModel>? itemsSleepPlaces}) {
    return EventsStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      itemsEventPlaces: itemsEventPlaces ?? this.itemsEventPlaces,
      itemsSleepPlaces: itemsSleepPlaces ?? this.itemsSleepPlaces,
    );
  }
}
