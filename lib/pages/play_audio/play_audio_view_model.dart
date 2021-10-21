import 'dart:async';
import 'dart:io';
import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/play_audio/play_audio_effect.dart';
import 'package:bogota_app/pages/play_audio/play_audio_status.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:connectivity/connectivity.dart';
import 'package:bogota_app/view_model.dart';

class PlayAudioViewModel extends EffectsViewModel<PlayAudioGuiaStatus, PlayAudioGuiaEffect>{
  final IdtRoute _route;
  final ApiInteractor _interactor;
  late String languageUser;

  PlayAudioViewModel(this._route, this._interactor) {
    status = PlayAudioGuiaStatus(
        isLoading: true,
        modeOffline: false,
        isOnline: true,
        urlAudio: IdtConstants.audio,
        pathAudio: '',
        isFavorite: false,
        language: 'Español',
        idAudio: '',
        connectionStatus: ConnectivityResult.none,
        message: '',
    );
  }

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void onInit() async {

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);   
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {

    print("status.connectionStatus ${status.connectionStatus}");
    status.connectionStatus = result;

  }

  void changeModeOffline(bool mode, String idAAudio) {
    if (mode) {
      loadFile();
    } else {
      status = status.copyWith(pathAudio: '');
      removeAudioLocalSavedPlaces(idAAudio);
    }
    print('File Swith: $mode');
    status = status.copyWith(modeOffline: mode, isOnline: mode);
  }

  dialogSiggestionLoginAudioModeOff(){
      addEffect(ShowDialogModeOffEffect());
  }

  dialogSuggestionLoginSavedPlace(){
    addEffect(ShowDialogAddSavedPlaceEffect());
  }

  removeAudioLocalSavedPlaces(String idAAudio){
    if(idAAudio != null){
      CurrentUser user = BoxDataSesion.getCurrentUser()!;
      Person person = BoxDataSesion.getFromBox(user.id_db!)!;
      List<DataAudioGuideModel> detailOfPerson = person.detalle ?? [];

      final index = detailOfPerson.indexWhere((element) => element.id == idAAudio);
      if(index != -1){
        detailOfPerson.removeAt(index);
      }
      var personUpdated = Person(name: person.name,id: person.id, country: person.country, apellido: person.apellido, detalle: detailOfPerson);

      BoxDataSesion.pushToBox(personUpdated, user.id_db!);
      print('✅ Se renueve audio almacenado localmente ${personUpdated.audioguias}');
    }
  
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
    List<DataAudioGuideModel> detailsData = [];

    //_audios.add(file.toString());
    Map<String, dynamic> details =  Map<String, dynamic>();
/*    details['id_audio'] = status.idAudio;
    details['path_audio'] = file.toString();*/
    details['id']=status.idAudio;
    details['title']=(status.detalleSaved! as DataAudioGuideModel).title;
    details['image']=(status.detalleSaved! as DataAudioGuideModel).main_img;
    details['audioguia_es']=status.pathAudio;
    details['audioguia_en']=status.pathAudio;
    details['audioguia_pt']=status.pathAudio;

    print("detalle ${details['128']}");
    // _audios.add(details);
    print("status.detalleSaved ${status.detalleSaved!.toJson()}");
    // detailsData.add(status.detalleSaved!);
    // print(status.detalleSaved!.id);
    //detailsData.add(status.detalleSaved!);

    print("detailsData $detailsData");
   // var person = Person(audioguias: _audios, audios: details);
   // BoxDataSesion.pushToBox(person);
try{
    CurrentUser user = BoxDataSesion.getCurrentUser()!;
    print("user.id_db! ${user.id_db!}");
    Person person = BoxDataSesion.getFromBox(user.id_db!)!;
    List<DataAudioGuideModel> detailOfPerson = person.detalle ?? [];

    final index = detailOfPerson.indexWhere((element) => element.id == details['id']);
    if(index == -1){
      detailOfPerson.add(DataAudioGuideModel.fromJson(details));
    }
    var personUpdated = Person(name: person.name,id: person.id, country: person.country, apellido: person.apellido, audioguias: _audios, detalle: detailOfPerson);

    BoxDataSesion.pushToBox(personUpdated, user.id_db!);
    print('✅ desde audioguías ${personUpdated.audioguias}');
}catch(e){
print(e);
}
  }

  void onTapFavorite() {
    final bool value = status.isFavorite;
    status = status.copyWith(isFavorite: !value);
    _interactor.postFavorite(status.idAudio).then((value) {
      print("⭐ Agregado a favoritos");
    });
  }

  void selectLanguage(Object? value) {
    status = status.copyWith(language: value.toString());
  }

  checkIsFavorite(String id) async {
    final isFavorite = await getIsFavorite(id);
    status = status.copyWith(isFavorite: isFavorite) ;
  }

  Future<bool> getIsFavorite(String id) async {
    languageUser = BoxDataSesion.getLaguageByUser(); //get language User Prefered
    bool isFavorite = false;
    // Actualización de lugares guardados/favoritos
    final dynamic savedPlaces = await _interactor.getSavedPlacesList(languageUser);
    if (savedPlaces is IdtSuccess<List<DataAudioGuideModel>?>) {
      List places = savedPlaces.body!;

      try {
        final DataAudioGuideModel lugarIsFavoriteSaved =
            places.firstWhere((element) => element.id == id);
        if (lugarIsFavoriteSaved != null) {
          isFavorite = true;
        }
      } catch (e) {
        isFavorite = false;
      }
    }
    return isFavorite;
  }
}
