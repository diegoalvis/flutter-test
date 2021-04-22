import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';

import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

import 'recover_pass_status.dart';

class RecoverPassViewModel extends ViewModel<RecoverPassStatus>  {
  final IdtRoute _route;
  final ApiInteractor _interactor;



  RecoverPassViewModel(this._route, this._interactor) {
    status = RecoverPassStatus(
      isLoading: false,

    );
  }

  void onInit() async {
    // status = status.copyWith(isLoading: true);
    // getUnmissableResponse();
    // getFoodResponse();
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
