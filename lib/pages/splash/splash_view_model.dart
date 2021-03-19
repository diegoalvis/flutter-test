import 'dart:ffi';

import 'package:bogota_app/data/model/places_model.dart';


import 'package:bogota_app/data/model/splash_model.dart';


import 'package:bogota_app/data/model/splash_model.dart';
import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/home/home_effect.dart';
import 'package:bogota_app/pages/home/home_status.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

import 'splash_status.dart';

class SplashViewModel extends ViewModel<SplashStatus> {
  final IdtRoute _route;
  final SplashRepository _interactor;

  SplashViewModel(this._route, this._interactor) {
    status = SplashStatus();
  }

  void onInit() async {
    // TODO
  }

  void getSplash() async {
    final response = await _interactor.getSplashInteractor();

    if (response is IdtSuccess<SplashModel>) {
      print('urlImgSplash: $response ');
      status = status.copyWith(imgSplash: IdtConstants.url_image + response.body.background.toString());
      await Future.delayed(Duration (seconds: 3));
      _route.goHome();
    } else {
      await Future.delayed(Duration (seconds: 3));
      _route.goHome();
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
  }
}
