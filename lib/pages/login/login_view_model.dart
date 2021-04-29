import 'dart:convert';

import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/request/login_request.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/login/login_status.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewModel extends ViewModel<LoginStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  LoginViewModel(this._route, this._interactor) {
    status = LoginStatus(
        isLoading: true,
        username: '',
        password: ''
    );
  }

  void onInit() async {
    // TODO
  }

  void loginResponse(String username, String password) async {
    LoginRequest params = LoginRequest(username, password);
    print('params');
    print(params.toJson());
    final loginResponse = await _interactor.login(params);

    if (loginResponse is IdtSuccess<RegisterModel?>) {
      print("model login");
      print(loginResponse);
    //  status = status.copyWith(itemsAudioGuide: audioguideResponse.body);
      /// Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
      _route.goHome();

    } else {
      final erroRes = loginResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }


  void goUserHomePage(String username, String password) {
    print('view model username');
    print(username);
    _route.goUserHome();
  }

}
