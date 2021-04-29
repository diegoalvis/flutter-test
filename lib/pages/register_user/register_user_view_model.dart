import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/request/register_request.dart';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';

import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

import 'register_user_status.dart';

class RegisterUserViewModel extends ViewModel<RegisterUserStatus>  {
  final IdtRoute _route;
  final ApiInteractor _interactor;



  RegisterUserViewModel(this._route, this._interactor) {
    status = RegisterUserStatus(
      isLoading: false,
      isAlert: false

    );
  }

  void onInit() async {
    // status = status.copyWith(isLoading: true);
    // getUnmissableResponse();
    // getFoodResponse();
  }
  registerResponse(RegisterRequest data ) async {
    print('entra a registro');

    final registerResponse = await _interactor.register(data);
    if (registerResponse is IdtSuccess<RegisterModel?>) {
      print("model register");
      print(registerResponse);
      //  status = status.copyWith(itemsAudioGuide: audioguideResponse.body);
      /// Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
      _route.goHome();
    } else {
      final erroRes = registerResponse as IdtFailure<RegisterModel?>;
      print('error en viewmodel');
      print(erroRes.message);
      status = status.copyWith(isAlert: true);
      UnimplementedError();

    }
    status = status.copyWith(isLoading: false);
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

  void goDiscoverPage() {
      _route.goDiscover();
  }
}
