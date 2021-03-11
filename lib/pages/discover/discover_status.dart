import 'package:bogota_app/view_model.dart';

class DiscoverStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final bool isZone;

  DiscoverStatus({required this.isLoading, required this.openMenu, required this.openMenuTab, required this.isZone});

  DiscoverStatus copyWith({bool? isLoading, bool? openMenu, bool? openMenuTab, bool? isZone }) {
    return DiscoverStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      isZone: isZone ?? this.isZone
    );
  }
}
