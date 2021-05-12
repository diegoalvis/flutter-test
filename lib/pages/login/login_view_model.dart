import 'dart:async';
import 'dart:convert';

import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/request/login_request.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/login/login_status.dart';
import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:unique_ids/unique_ids.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_effect.dart';



  class LoginViewModel extends EffectsViewModel<LoginStatus, LoginEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  LoginViewModel(this._route, this._interactor) {
  status = LoginStatus(
  isLoading: true,
  email: '',
  password: '',
  message: ''
  );
  }

  String imei='';
  String latitud='';
  String longitud='';
  String fecha = '';
  Location locationUser = Location();
  GpsModel location = GpsModel();
  void onInit() async {
    // TODO
  }

  void loginResponse(String email, String password) async {
    LoginRequest params = LoginRequest(email, password);
    print('params');
    print(params.toJson());
    final loginResponse = await _interactor.login(params);

    if (loginResponse is IdtSuccess<RegisterModel?>) {
      print("model login");
      print(loginResponse);
    //  status = status.copyWith(itemsAudioGuide: audioguideResponse.body);
      /// Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    //  addEffect(ShowLoginDialogEffect());
      if (loginResponse.body!.message != null){
        print('entra a if');
        print(loginResponse.body!.message);
      status = status.copyWith(message: loginResponse.body!.message);
      print(status.message);
      addEffect(ShowLoginDialogEffect(status.message));
      }else{
        print('entra a else');
        _route.goHome();
        _serviceEn();
        _servicePer();
        Timer.periodic(Duration(minutes: 2), (timer) {
          _init();
          print(DateTime.now());
          getLoc();
        });
        setLocationUser();
        _savedata(loginResponse.body!);
      }



    } else {
      print('se imprime login response');
      print(loginResponse);
      final erroRes = loginResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
      addEffect(ShowLoginDialogEffect(status.message));
    }
    status = status.copyWith(isLoading: false);
  }

  _savedata(RegisterModel loginResponse) async{
    var box = await Hive.openBox<Person>('userdbB');

  //  var fooBox = await Hive.openBox<List>("userdb");

    var person = Person(
        name: loginResponse.name,
        id: loginResponse.id,
        country: loginResponse.country
    );

    await box.put(loginResponse.name, person);

    print('datos almacenados del login');
    print(box.getAt(0)!.id);
    print(box.get(loginResponse.name)!.audioguias);
    print(box.get(loginResponse.name)!.country);

  }

  getLoc() async{

    LocationData _currentPosition;
    String _address,_dateTime;
    _currentPosition = await locationUser.getLocation();

    print(_currentPosition);
    longitud=_currentPosition.longitude.toString();
    latitud=_currentPosition.latitude.toString();
    fecha =_currentPosition.time.toString();
  }


  Future<void> _init() async {
    String? adId;
    String? uuid;

    try {
      uuid = await UniqueIds.uuid;
    } on PlatformException {
      uuid = 'Failed to create uuid.v1';
    }

    try {
      adId = await UniqueIds.adId;
    } on PlatformException {
      adId = 'Failed to get adId version.';
    }
    location.imei= uuid.toString();
    print(uuid);
    imei=uuid.toString();
  }
  _serviceEn() async{
    bool _serviceEnabled;
    _serviceEnabled = await locationUser.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationUser.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }
  _servicePer()async{

    PermissionStatus _permissionGranted;
    _permissionGranted = await locationUser.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationUser.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

  }
  Future <void> setLocationUser() async  {

    final GpsModel location = GpsModel(
        imei: 'imei',
        longitud: 'longitud',
        latitud: 'latitud',
        fecha: 'fecha',
        nombre: 'marisol',
        apellido: 'manquillo',
        motivo_viaje: 'turismo',
        pais: 'Colombia',
        ciudad: 'popayan'
    );
  print('setlocationuser');
  print(location.toJson());
    final response = await _interactor.postLocationUser(location);

    if (response is IdtSuccess<GpsModel?>) {
      final places = response.body!;
      print('Response: ${places.fecha}');
    } else {

      final erroRes = response as IdtFailure<GpsError>;
      print(erroRes.message);
      UnimplementedError();
    }
  }


  void onChangeScrollController(bool value) {
    addEffect(LoginValueControllerScrollEffect(value));
  }

  void goUserHomePage(String username, String password) {
    print('view model username');
    print(username);
    _route.goUserHome();
  }

}
