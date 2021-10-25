import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class AudioGuideStatus extends ViewStatus {
  final bool isLoading;
  final bool openMenu;
  final bool openMenuTab;
  late final String nameFilter;
  late List<DataAudioGuideModel> itemsAudioGuide;
  late List<DataModel> zones;

  AudioGuideStatus({
    required this.nameFilter,
    required this.isLoading,
    required this.openMenu,
    required this.openMenuTab,
    required this.itemsAudioGuide,
    required this.zones,
  });

  AudioGuideStatus copyWith(
      {bool? isLoading,
      String? nameFilter,
      bool? openMenuTab,
      bool? openMenu,
      List<DataAudioGuideModel>? itemsAudioGuide,
      List<DataModel>? zones}) {
    return AudioGuideStatus(
        nameFilter: nameFilter ?? this.nameFilter,
        openMenuTab: openMenuTab ?? this.openMenuTab,
        isLoading: isLoading ?? this.isLoading,
        openMenu: openMenu ?? this.openMenu,
        itemsAudioGuide: itemsAudioGuide ?? this.itemsAudioGuide,
        zones: zones ?? this.zones);
  }
}
