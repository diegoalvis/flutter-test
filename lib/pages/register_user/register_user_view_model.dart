import 'dart:convert';

import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/request/register_request.dart';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/register_user/register_user_effect.dart';

import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/admin/directory_v1.dart';
import "package:http/http.dart" as http;

import '../../data/model/request/register_request.dart';
import 'register_user_status.dart';
import 'register_user_effect.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
//import 'package:googleapis/people/v1.dart';
import 'package:bogota_app/data/local/user.dart';



class RegisterUserViewModel extends EffectsViewModel<RegisterUserStatus, RegisterEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;


  RegisterUserViewModel(this._route, this._interactor) {
    status = RegisterUserStatus(
      isLoading: false,
      data: null,
    );
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

  Future<void>handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      await registerWithGoogle();
    } catch (error) {
      print(error);
    }
  }

 registerWithGoogle(){
   _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        _currentUser = account;
        print("current user$_currentUser");
      if (_currentUser != null) {
        print("hay datos");
        GoogleSignInAccount? user = _currentUser;
        registerResponse(user?.displayName ?? 'Nombre por defecto', user?.displayName ?? 'Nombre por defecto',
            user?.email ?? 'Nombre por defecto', 'Colombia',
            user?.displayName ?? 'Nombre por defecto', 'Turismo', '12345');
       // _handleGetContact(_currentUser!);
      }
    });
  // _googleSignIn.signInSilently();

   // GoogleSignInAccount? user = _currentUser;

/*     if(_currentUser != null){
       _route.goHome();
*//*       registerResponse(user?.displayName ?? 'Nombre por defecto', user?.displayName ?? 'Nombre por defecto',
           user?.email ?? 'Nombre por defecto', 'Colombia',
           user?.displayName ?? 'Nombre por defecto', 'Turismo', '12345');*//*
     }else{
       _route.goLogin();
     }*/

   _handleSignOut();

 }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'];
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => 'null',
    );
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => 'null',
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    _contactText = "Loading contact info...";

    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      _contactText = "People API gave a ${response.statusCode} "
          "response. Check logs for details.";

      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String? namedContact = _pickFirstNamedContact(data);

    if (namedContact != null) {
      _contactText = "I see you know $namedContact!";
    } else {
      _contactText = "No contacts to display.";
    }
  }
    bool _validemessage(RegisterModel registerResponse) {
      Map<String, dynamic> data = registerResponse.toJson();
      if (data.containsKey('message') && data['message'] != null) {
        return true;
      }
      return false;
    }

   _handleSignIn()  {
      try {
         _googleSignIn.signIn();
         registerWithGoogle();

      } catch (error) {
        print(error);
      }
    }/*
  Future<void> _valideSignIn() async {
    try {
      if(_currentUser != null){
        registerWithGoogle();
      }else{

      }

    } catch (error) {
      print(error);
    }
  }*/


    Future<void> _handleSignOut() => _googleSignIn.disconnect();

    void onInit() async {
      //await handleSignIn();
      // registerResponse( );
      status = status.copyWith(isLoading: false);
    }

    registerResponse(String name , String username, String mail, String country,
        String lastName, String reasonTrip, String password) async {
      status = status.copyWith(isLoading: true);
      RegisterRequest params = RegisterRequest(
        // 'name','name','name@gmail.com', 'col', 'apellido', 'asd', '1234'
          name,
          username,
          mail,
          country,
          lastName,
          reasonTrip,
          password
      );
      print(params.toJson());
      final registerResponse = await _interactor.register(params);


      if (registerResponse is IdtSuccess<RegisterModel?>) {
        final messageExist = _validemessage(registerResponse.body!);
        if (messageExist) {
          status = status.copyWith(message: registerResponse.body!.message);
          print(status.message);
          status = status.copyWith(isLoading: false);
          addEffect(ShowRegisterDialogEffect(status.message));
        } else {
          _savedata(registerResponse.body!);
          _route.goHome();
        }
      } else {
        final erroRes = registerResponse as IdtFailure<RegisterModel?>;
        UnimplementedError();
        Map<String, dynamic> errorMail = jsonDecode(erroRes.message);
        status = status.copyWith(message: errorMail['error']['mail']);
        print(status.message);
        addEffect(ShowRegisterDialogEffect(status.message));
      }
      status = status.copyWith(isLoading: false);
    }

  _savedata(RegisterModel loginResponse) async {
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
    print('✅ datos almacenados del login');
  }


    void setLocationUser() async {
      final GpsModel location = GpsModel(
          imei: '999',
          longitud: '-78.229',
          latitud: '2.3666',
          fecha: '03/19/21'
      );
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

    bool validatePassword(String pass, String confirmPass) {
      print('valida');
      if (pass == confirmPass) {
        return true;
      }
      else {
        addEffect(ShowRegisterDialogEffect(status.message));
        return false;
      }
    }

    validateEmail(String value) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0) {
        addEffect(ShowRegisterDialogEffect(status.message));
        return "El correo es necesario";
      } else if (!regExp.hasMatch(value)) {
        addEffect(ShowRegisterDialogEffect(status.message));
        return "Correo invalido";
      }
      return 'null';
    }

    void goDiscoverPage() {
      _route.goDiscover();
    }

    void onChangeScrollController(bool value) {
      addEffect(RegisterValueControllerScrollEffect(value));
    }


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


    Future<void> registerFacebook() async {
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
        print("_userData_register");
        print(_userData);

        RegisterRequest params = RegisterRequest(
            _userData!['name'],
            _userData!['name'],
            _userData!['email'],
            'Colombia',
            _userData!['name'],
            'turismo',
            _userData!['id']);

        status = status.copyWith(data: params);
        // registerResponse();

      } else {
        print(result.status);
        print(result.message);
      }
    }

    Future<void> registerGoogle() async {
      print("register google");

      try {
        await _googleSignIn.signIn();
        ;
        _route.goHome();
      } catch (error) {
        print(error);

        //  Future<void> _handleSignOut() => _googleSignIn.disconnect();
      }
    }
    login(int state) async {
      print("state");
      print(state);
      switch (state) {
        case 1:
          await registerFacebook();
          break;
        case 2:
          await _handleSignIn();
          return;
        default:
          break;
      }
    }
  }

/*  String? _pickFirstNamedContact(List<Person>? connections) {
    return connections
        ?.firstWhere(
          (Person person) => person.names != null,
    )
        .names
        ?.firstWhere(
          (Name name) => name.displayName != null,
    )
        .displayName;
  }

}*/

class User {
  String? email;
  String? name;
  String? profilePicURL;
  User({this.email, this.name ,this.profilePicURL});
}
