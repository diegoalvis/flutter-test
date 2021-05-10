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

import 'register_user_status.dart';
import 'register_user_effect.dart';


class RegisterUserViewModel extends EffectsViewModel<RegisterUserStatus, RegisterEffect>  {
  final IdtRoute _route;
  final ApiInteractor _interactor;



  RegisterUserViewModel(this._route, this._interactor) {
    status = RegisterUserStatus(
      isLoading: false,
      data : null,
    );
  }

  void onInit() async {
    // status = status.copyWith(isLoading: true);
    // getUnmissableResponse();
    registerResponse( );
    status = status.copyWith(isLoading: true);
  }
  registerResponse( ) async {
    status = status.copyWith(isLoading: true);
    final registerResponse = await _interactor.register(status.data!);

    if (registerResponse is IdtSuccess<RegisterModel?>) {
      final messageExist = _validemessage(registerResponse.body!);
      if (messageExist ){
        status = status.copyWith(message: registerResponse.body!.message);
        print(status.message);
        status = status.copyWith(isLoading: false);
        addEffect(ShowRegisterDialogEffect(status.message));
      }else{
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

bool _validemessage(RegisterModel registerResponse){
      Map<String, dynamic> data = registerResponse.toJson();
      if (data.containsKey('message') && data['message'] != null){
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

  bool validatePassword(String pass, String confirmPass){

    print('valida');
    if(pass==confirmPass){
      return true;
    }
    else{
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
}
