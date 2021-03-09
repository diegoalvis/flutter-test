import 'package:bogota_app/view_model.dart';

class DiscoverStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;

  DiscoverStatus({required this.isLoading, required this.openMenu, required this.openMenuTab});

  DiscoverStatus copyWith({bool? isLoading, bool? openMenu, bool? openMenuTab }) {
    return DiscoverStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab
    );
  }
}
