import 'package:bogota_app/view_model.dart';

class AudioGuideStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;

  AudioGuideStatus({required this.isLoading, required this.openMenu});

  AudioGuideStatus copyWith({bool? isLoading, bool? openMenu}) {
    return AudioGuideStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu
    );
  }
}
