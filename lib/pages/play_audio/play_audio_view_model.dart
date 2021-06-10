import 'dart:io';

import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/play_audio/play_audio_status.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class PlayAudioViewModel extends ViewModel<PlayAudioStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  PlayAudioViewModel(this._route, this._interactor) {
    status = PlayAudioStatus(
        isLoading: true,
        modeOffline: false,
        isOnline: true,
        urlAudio: IdtConstants.audio,
        pathAudio: '',
        isFavorite: false,
        language: 'Español');
  }

  void onInit() async {
    // TODO
  }

  void changeModeOffline(bool mode) {
    if (mode) {
      loadFile();
    } else {
      status = status.copyWith(pathAudio: '');
    }
    print('File Swith: $mode');
    status = status.copyWith(modeOffline: mode, isOnline: mode);
  }

  Future loadFile() async {
    //TODO: Crear un loading para esta descarga
    print("status.urlAudio");
    print(status.urlAudio);
    // final bytes = await readBytes(Uri.file(status.urlAudio, windows: true));
    var bytes = await readBytes(Uri.https('bogotadc.travel',
        '/drpl/sites/default/files/2021-03/samplebta_1.mp3')); //close();
    final dir = await pathProvider.getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');
    // var request = await Uri.https('https://bogotadc.travel', '/drpl/sites/default/files/2021-03/samplebta_1.mp3');

    // await file.writeAsBytes(bytes);

    await file.writeAsBytes(bytes);
    print(file.path);
    print('File descargado: $file');
    if (await file.exists()) {
      status = status.copyWith(pathAudio: file.path);
    }
    _savedata(file.path);

  }

  _savedata(String file) async {
    List<Map> _audios = [];

    //_audios.add(file.toString());

    var details = Map();
    details['id_audio'] = 'id_audio_';
    details['path_audio'] = file.toString();

    _audios.add(details);

   // var person = Person(audioguias: _audios, audios: details);
   // BoxDataSesion.pushToBox(person);

    CurrentUser user = BoxDataSesion.getCurrentUser()!;

    Person person = BoxDataSesion.getFromBox(user.id_db!)!;

    var personUpdated = Person(name: person.name,id: person.id, country: person.country, apellido: person.apellido, audioguias: _audios);

    BoxDataSesion.pushToBox(personUpdated, user.id_db!);
    print('✅ desde audioguías ${personUpdated.audioguias}');
  }

  void onTapFavorite() {
    final bool value = status.isFavorite;
    status = status.copyWith(isFavorite: !value);
  }

  void selectLanguage(Object? value) {
    status = status.copyWith(language: value.toString());
  }
}
