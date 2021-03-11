import 'package:bogota_app/view_model.dart';

class FiltersStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final bool openMenuFilter;

  FiltersStatus({required this.isLoading, required this.openMenu, required this.openMenuTab, required this.openMenuFilter});

  FiltersStatus copyWith({bool? isLoading, bool? openMenu, bool? openMenuTab, bool? openMenuFilter }) {
    return FiltersStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      openMenuFilter: openMenuFilter ?? this.openMenuFilter
    );
  }
}
