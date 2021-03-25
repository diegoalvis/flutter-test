import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/view_model.dart';

class EventsStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  late List<DataPlacesModel> itemsSleepPlaces;

  EventsStatus({required this.isLoading, required this.openMenu, required this.openMenuTab, required this.itemsSleepPlaces});

  EventsStatus copyWith({bool? isLoading, bool? openMenu, bool? openMenuTab, List<DataPlacesModel>? itemsSleepPlaces }) {
    return EventsStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      itemsSleepPlaces: itemsSleepPlaces ??this.itemsSleepPlaces
    );
  }
}
