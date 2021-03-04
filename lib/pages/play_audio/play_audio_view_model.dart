import 'dart:io';

import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/play_audio/play_audio_status.dart';
import 'package:bogota_app/view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';

class PlayAudioViewModel extends ViewModel<PlayAudioStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  PlayAudioViewModel(this._route, this._interactor) {
    status = PlayAudioStatus(
      isLoading: true,
      modeOffline: false,
      isOnline: true,
      urlAudio: IdtConstants.audio,
      pathAudio: ''
    );
  }

  void onInit() async {
    //TODO
  }

  void changeModeOffline(bool mode) {

    if(mode){
      loadFile();
    } else {
      status = status.copyWith(pathAudio: '');
    }
    print('File Swith: $mode');
    status = status.copyWith(modeOffline: mode, isOnline: mode);
  }

  Future loadFile() async {

    //TODO: Crear un loading para esta descarga
    final bytes = await readBytes(status.urlAudio);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);

    print('File descargado: $file');
    if (await file.exists()) {
      status = status.copyWith(pathAudio: file.path);
    }
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

}
