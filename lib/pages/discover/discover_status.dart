import 'package:bogota_app/view_model.dart';

class DiscoverStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;

  DiscoverStatus({this.isLoading, this.openMenu, this.openMenuTab});

  DiscoverStatus copyWith({bool isLoading, bool openMenu, bool openMenuTab }) {
    return DiscoverStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab
    );
  }
}
