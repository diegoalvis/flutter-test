import 'package:bogota_app/view_model.dart';

class EventsStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;

  EventsStatus({this.isLoading, this.openMenu, this.openMenuTab});

  EventsStatus copyWith({bool isLoading, bool openMenu, bool openMenuTab }) {
    return EventsStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab
    );
  }
}
