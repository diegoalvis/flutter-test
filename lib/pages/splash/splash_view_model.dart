import 'dart:ffi';

import 'package:bogota_app/data/model/splash_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:connectivity/connectivity.dart';

import 'splash_status.dart';

class SplashViewModel extends ViewModel<SplashStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  //solid color #2164ac blue-Splash.

  SplashViewModel(this._route, this._interactor) {
    status = SplashStatus();
  }

  void onInit() async {
    Future.delayed(const Duration(milliseconds: 500), () {
    getSplash();
    });
  }

  void getSplash() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print("connectivityResult $connectivityResult");
    late String languageUser;

    if (connectivityResult != ConnectivityResult.none) {
      //todo obtener usuario para el idioma
      // languageUser = BoxDataSesion.getLaguageByUser();

      final response = await _interactor.getSplashInteractor('es');

      if (response is IdtSuccess<SplashModel>) {
        status = status.copyWith(title: response.body.title,
            imgSplash: IdtConstants.url_image +
                response.body.background.toString());
        await Future.delayed(Duration(seconds: 10));
        _route.goSelectLanguage();
      } else {
        await Future.delayed(Duration(seconds: 10));
        _route.goSelectLanguage();
        final erroRes = response as IdtFailure<FilterError>;
        print(erroRes.message);
        UnimplementedError();
      }
    } else {
      _route.goSavedPlaces();
    }
  }
}
