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
import 'package:bogota_app/view_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/admin/directory_v1.dart';

import '../../data/model/request/register_request.dart';
import 'register_user_status.dart';
import 'register_user_effect.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/people/v1.dart';




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

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[PeopleServiceApi.contactsReadonlyScope],
  );
  GoogleSignInAccount? _currentUser;
  String? _contactText;

  void onInit() async {
    // registerResponse( );
    status = status.copyWith(isLoading: false);
  }

  registerResponse(String name, String username, String mail, String country,
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

  bool _validemessage(RegisterModel registerResponse) {
    Map<String, dynamic> data = registerResponse.toJson();
    if (data.containsKey('message') && data['message'] != null) {
      return true;
    }
    return false;
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

  login(int state) async {
    print("state");
    print(state);
    switch (state) {
      case 1:
        registerFacebook();
        break;
      case 2:

        registerGoogle();
        return;
      default:
        break;
    }
  }
  Future<User> register_Google() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email',"https://www.googleapis.com/auth/userinfo.profile"]);
    await googleSignIn.signIn();
   var id = googleSignIn.clientId;
print("client id $id");

    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {

        _currentUser = account;
        print("_currentUser!.id");
        print(_currentUser!.id);


    });


    User user = User(
        email: googleSignIn.currentUser!.email,
        name: googleSignIn.currentUser!.displayName,
        profilePicURL: googleSignIn.currentUser!.photoUrl,

    );

    print(user.name);
    return user;
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
      await initgoogle();
      _route.goHome();
    } catch (error) {
      print(error);

      //  Future<void> _handleSignOut() => _googleSignIn.disconnect();
    }
  }



  Future <void> initgoogle() async {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;

      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact() async {
      _contactText = 'Loading contact info...';


    final PeopleServiceApi peopleApi =
    PeopleServiceApi((await _googleSignIn.authenticatedClient())!);
    final ListConnectionsResponse response =
    await peopleApi.people.connections.list(
      'people/me',
      personFields: 'names',
    );

    final String? firstNamedContactName =
    _pickFirstNamedContact(response.connections);

      if (firstNamedContactName != null) {
        _contactText = 'I see you know $firstNamedContactName!';
      } else {
        _contactText = 'No contacts to display.';
      }
  }

  String? _pickFirstNamedContact(List<Person>? connections) {
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

}

class User {
  String? email;
  String? name;
  String? profilePicURL;
  User({this.email, this.name ,this.profilePicURL});
}
