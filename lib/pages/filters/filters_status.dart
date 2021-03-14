import 'package:bogota_app/view_model.dart';

class FiltersStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final bool openMenuFilter;
  final List<bool> filter1;
  final List<bool> filter2;
  final List<bool> filter3;

  FiltersStatus({required this.isLoading, required this.openMenu, required this.openMenuTab, required this.openMenuFilter,
    required this.filter1, required this.filter2, required this.filter3});

  FiltersStatus copyWith({bool? isLoading, bool? openMenu, bool? openMenuTab, bool? openMenuFilter,
    List<bool>? filter1, List<bool>? filter2, List<bool>? filter3}) {
    return FiltersStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      openMenuFilter: openMenuFilter ?? this.openMenuFilter,
      filter1: filter1 ?? this.filter1,
      filter2: filter2 ?? this.filter2,
      filter3: filter3 ?? this.filter3,
    );
  }
}
