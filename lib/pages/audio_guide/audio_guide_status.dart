import 'package:bogota_app/view_model.dart';

class AudioGuideStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;

  AudioGuideStatus({this.isLoading, this.openMenu});

  AudioGuideStatus copyWith({bool isLoading, bool openMenu}) {
    return AudioGuideStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu
    );
  }
}
