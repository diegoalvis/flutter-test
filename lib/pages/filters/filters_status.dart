import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class FiltersStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final bool openMenuFilter;
  final List<DataModel?> filter1;
  final List<DataModel?> filter2;
  final List<DataModel?> filter3;
  late List<DataModel> itemsFilter;

  FiltersStatus({required this.isLoading, required this.openMenu, required this.openMenuTab, required this.openMenuFilter,
    required this.filter1, required this.filter2, required this.filter3,required this.itemsFilter});

  FiltersStatus copyWith({bool? isLoading, bool? openMenu, bool? openMenuTab, bool? openMenuFilter,
    List<DataModel?>? filter1, List<DataModel?>? filter2, List<DataModel?>? filter3, List<DataModel>? itemsFilter}) {
    return FiltersStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      openMenuFilter: openMenuFilter ?? this.openMenuFilter,
      filter1: filter1 ?? this.filter1,
      filter2: filter2 ?? this.filter2,
      filter3: filter3 ?? this.filter3,
      itemsFilter: itemsFilter ?? this.itemsFilter
    );
  }
}
