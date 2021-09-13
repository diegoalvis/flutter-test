import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/language_model.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile/profile_status.dart';
import 'package:bogota_app/utils/errors/user_data_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';

import 'select_language_status.dart';

class SelectLanguageViewModel extends ViewModel<SelectLanguageStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  SelectLanguageViewModel(this._route, this._interactor) {
    status = SelectLanguageStatus(
      isLoading: false,
      languagesAvalibles: [],
    );
  }

  void onInit() async {
    getAvailableLanguages();
  }

  void getAvailableLanguages() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print("connectivityResult $connectivityResult");

    if (connectivityResult != ConnectivityResult.none) {
      final response = await _interactor.getLanguageAvalible();

      if (response is IdtSuccess<List<LanguageModel>?>) {
        status = status.copyWith(languagesAvalibles: response.body);
      }
    }
  }
}
