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
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:unique_ids/unique_ids.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_effect.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginViewModel extends EffectsViewModel<LoginUserStatus, LoginEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;


  LoginViewModel(this._route, this._interactor) {
    status =
        LoginUserStatus(isLoading: false, email: '', password: '', message: '', rememberMe: false);
  }

  String imei = '';
  String latitud = '';
  String longitud = '';
  String fecha = '';
  Location locationUser = Location();
  GpsModel location = GpsModel();

  void onInit() async {
    status = status.copyWith(isLoading: false);
  }

  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  void rememberMe(){
    status = status.copyWith(rememberMe: !(status.rememberMe!));
    print(status.rememberMe);
  }

  void loginResponse(String email, String password) async {
    status = status.copyWith(isLoading: true);
    LoginRequest params = LoginRequest(email, password);
    print('params');
    print(params.toJson());
    final loginResponse = await _interactor.login(params);

    if (loginResponse is IdtSuccess<RegisterModel?>) {

      if (loginResponse.body!.message != null) {
        print('entra a if');
        print(loginResponse.body!.message);
        status = status.copyWith(message: loginResponse.body!.message);
        print(status.message);
        addEffect(ShowLoginDialogEffect(status.message));
        status = status.copyWith(isLoading: false);
      } else {
        print('entra a else');
        //todo diccionario
        // _route.goHome();
        _serviceEn();
        _servicePer();
        Timer.periodic(Duration(seconds: 15), (timer) {
          _init();
          print('Time Now: ${DateTime.now()}');
          getLoc();
        });
        setLocationUser();
        _savedata(loginResponse.body!, email, password);
      }
    } else {
      print('se imprime login response');
      print(loginResponse);
      final erroRes = loginResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
      addEffect(ShowLoginDialogEffect(status.message));
    }
  }

  _savedata(RegisterModel loginResponse, String email, String password) async {
    //  var fooBox = await Hive.openBox<List>("userdb");

    var person = Person(
        name: loginResponse.name,
        id: loginResponse.id,
        country: loginResponse.country);

   bool valideUser = await BoxDataSesion.existInBox(person);
   print("validación de usuario $valideUser");

    var currentUser = CurrentUser(
      id_user: loginResponse.id
    );

   if (valideUser==false){
    int indexbox=  await BoxDataSesion.addToBox(person);
    currentUser.id_db= indexbox;
     BoxDataSesion.pushToBoxCurrentU(currentUser);
   }else{
     int index = await BoxDataSesion.getIndex(person);
     currentUser.id_db= index;
     BoxDataSesion.pushToBoxCurrentU(currentUser);
   }

   if(status.rememberMe!){
     var rememberUser = RememberMe(
         email: email,
         password: password,
         state: status.rememberMe!
     );
     var result=  await BoxDataSesion.addToRememberBox(rememberUser);
     print("rememeber User $result");
   }

    //await box.put(loginResponse.name, person);
    //BoxDataSesion.pushToBox(person);


    print('✅ datos almacenados del login');
  }

  getLoc() async {
    LocationData _currentPosition;
    String _address, _dateTime;
    _currentPosition = await locationUser.getLocation();

    print(_currentPosition);
    longitud = _currentPosition.longitude.toString();
    print(longitud);
    latitud = _currentPosition.latitude.toString();
    print(latitud);
    fecha = _currentPosition.time.toString();
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
    location.imei = uuid.toString();
    print(uuid);
    imei = uuid.toString();
  }

  _serviceEn() async {
    bool _serviceEnabled;
    _serviceEnabled = await locationUser.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationUser.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  _servicePer() async {
    PermissionStatus _permissionGranted;
    _permissionGranted = await locationUser.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationUser.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> setLocationUser() async {
    final GpsModel location = GpsModel(
        imei: 'imei',
        longitud: 'longitud',
        latitud: 'latitud',
        fecha: 'fecha',
        nombre: 'marisol',
        apellido: 'manquillo',
        motivo_viaje: 'turismo',
        pais: 'Colombia',
        ciudad: 'popayan');
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
    //todo diccionario
    // _route.goUserHome();
  }

/*
  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      print("userData");
      print(userData['name']);
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }
  */

  Future<void> logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    //setState(() {});
  }

  void _printCredentials() {
    print(
      prettyPrint(_accessToken!.toJson()),
    );
  }

  login(int state) async {
    print("state");
    print(state);
    switch (state) {
      case 1:
        await loginFacebook();
        break;
      case 2:
        await _handleSignIn();
        return;
      default:
        break;
    }
  }


  _handleSignIn()  {
    try {
      _googleSignIn.signIn();
      loginWithGoogle();

    } catch (error) {
      print(error);
    }
  }
  loginWithGoogle(){
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;
      print("current user$_currentUser");
      if (_currentUser != null) {
        print("hay datos");
        GoogleSignInAccount? user = _currentUser;
        loginResponse(user?.email ?? 'Nombre por defecto', '12345');
        // _handleGetContact(_currentUser!);
      }
    });

    _handleSignOut();

  }
  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Future<void> loginFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by the fault we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
      //todo diccionario
      // _route.goHome();
    } else {
      print(result.status);
      print(result.message);
    }
  }

  validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '* Contraseña necesaria';
    } else if (value.length < 8) {
      return '* Contraseña incompleta';
    }
    return null;
  }

  validateEmail(String? value, String email){
  if (value == null || value.isEmpty) {
  return '* Email necesario';
  } else if (!EmailValidator.validate(email)) {
  return '* Email invalido';
  }
  return null;
  }
}
