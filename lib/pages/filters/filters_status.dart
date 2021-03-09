import 'package:bogota_app/view_model.dart';

class FiltersStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;

  FiltersStatus({required this.isLoading, required this.openMenu, required this.openMenuTab});

  FiltersStatus copyWith({bool? isLoading, bool? openMenu, bool? openMenuTab }) {
    return FiltersStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab
    );
  }
}
