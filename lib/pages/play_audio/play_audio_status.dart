import 'package:bogota_app/view_model.dart';

class PlayAudioStatus extends ViewStatus{

  final bool isLoading;
  final bool modeOffline;
  final bool isOnline;
  final String urlAudio;
  final String pathAudio;

  PlayAudioStatus({required this.isLoading, required this.modeOffline, required this.isOnline, required this.urlAudio, required this.pathAudio});

  PlayAudioStatus copyWith({bool? isLoading, bool? modeOffline, bool? isOnline, String? urlAudio, String? pathAudio }) {
    return PlayAudioStatus(
      isLoading: isLoading ?? this.isLoading,
      modeOffline: modeOffline ?? this.modeOffline,
      isOnline: isOnline ?? this.isOnline,
      urlAudio: urlAudio ?? this.urlAudio,
      pathAudio: pathAudio ?? this.pathAudio
    );
  }
}
