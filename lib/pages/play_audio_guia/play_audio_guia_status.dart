import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/view_model.dart';
import 'package:connectivity/connectivity.dart';

class PlayAudioGuiaStatus extends ViewStatus{

  final bool isLoading;
  late bool modeOffline;
  final bool isOnline;
  late  String urlAudio;
  final String pathAudio;
  late bool isFavorite;
  final String language;
  late String idAudio;
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  late DataAudioGuideModel? detalleSaved;
  final String? message;

  PlayAudioGuiaStatus({required this.message, required this.isLoading, required this.modeOffline, required this.isOnline, required this.urlAudio,
    required this.pathAudio, required this.isFavorite, required this.language, required this.idAudio,
  required this.connectionStatus,  this.detalleSaved});

  PlayAudioGuiaStatus copyWith({String? message, bool? isLoading, bool? modeOffline, bool? isOnline, String? urlAudio, String? pathAudio,
    bool? isFavorite, String? language, String? idAudio, ConnectivityResult? connectionStatus, DataAudioGuideModel? detalleSaved}) {
    return PlayAudioGuiaStatus(
      message: message??this.message,
      isLoading: isLoading ?? this.isLoading,
      modeOffline: modeOffline ?? this.modeOffline,
      isOnline: isOnline ?? this.isOnline,
      urlAudio: urlAudio ?? this.urlAudio,
      pathAudio: pathAudio ?? this.pathAudio,
      isFavorite: isFavorite ?? this.isFavorite,
      language: language ?? this.language,
      idAudio: idAudio ?? this.idAudio,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      detalleSaved: detalleSaved?? this.detalleSaved

    );
  }
}
