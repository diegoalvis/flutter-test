import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class DiscoverStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final List<DataModel> listOptions;
  final String section;
  final int currentOption;


  DiscoverStatus({required this.isLoading, required this.openMenu, required this.openMenuTab,
    required this.listOptions, required this.section, this.currentOption = -1});

  DiscoverStatus copyWith({bool? isLoading, bool? openMenu, bool? openMenuTab, bool? isZone,
    List<DataModel>? listOptions, String? section, int? currentOption}) {
    return DiscoverStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      listOptions: listOptions ?? this.listOptions,
      section: section ?? this.section,
      currentOption: currentOption ?? this.currentOption,
    );
  }
}
