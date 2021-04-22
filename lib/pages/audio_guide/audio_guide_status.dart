import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/view_model.dart';

class AudioGuideStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  late List<DataAudioGuideModel> itemsAudioGuide;

  AudioGuideStatus({required this.isLoading, required this.openMenu,required this.itemsAudioGuide});

  AudioGuideStatus copyWith({bool? isLoading, bool? openMenu, List<DataAudioGuideModel>? itemsAudioGuide }) {
    return AudioGuideStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      itemsAudioGuide: itemsAudioGuide ?? this.itemsAudioGuide,
    );
  }
}
