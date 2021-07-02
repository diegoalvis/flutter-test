import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/view_model.dart';

class ActivityStatus extends ViewStatus {
  List<DataPlacesDetailModel> detail = [];
  bool isHotel;
  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  final List<DataModel> listOptions;
  final String section;
  final int currentOption;

  ActivityStatus({
    required this.detail,
    required this.isHotel,
    required this.isLoading,
    required this.openMenu,
    required this.openMenuTab,
    required this.listOptions,
    required this.section,
    this.currentOption = -1,
  });

  ActivityStatus copyWith(
      {List<DataPlacesDetailModel>? detail,
      bool? isHotel,
      bool? isLoading,
      bool? openMenu,
      bool? openMenuTab,
      List<DataModel>? listOptions,
      String? section,
      int? currentOption}) {
    return ActivityStatus(
      detail: detail ?? this.detail,
      isHotel: isHotel ?? this.isHotel,
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openMenuTab: openMenuTab ?? this.openMenuTab,
      listOptions: listOptions ?? this.listOptions,
      section: section ?? this.section,
      currentOption: currentOption ?? this.currentOption,
    );
  }
}
