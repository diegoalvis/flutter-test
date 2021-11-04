import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/language_model.dart';
import 'package:bogota_app/data/model/words_and_menu_images_model.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile/profile_status.dart';
import 'package:bogota_app/utils/errors/menu_images_error.dart';
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
  late String languageUser;

  SelectLanguageViewModel(this._route, this._interactor) {
    status = SelectLanguageStatus(
      indexSelect: null,
      isLoading: false,
      isButtonEnable: false,
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
        List<LanguageModel>? languagesAvalibles = response.body;
        status = status.copyWith(languagesAvalibles: languagesAvalibles);
        BoxDataSesion.pushToLanguagesAvalible(lan: languagesAvalibles);
      }
    }
  }
  void nextHome() {
    status = status.copyWith(isButtonEnable: true);
  }

  void goHomeWithWordsAndImagesMenu() async {
    status = status.copyWith(isLoading: true);
    languageUser = BoxDataSesion.getLaguageByUser();
    final response = await _interactor.getWordsAndImagesMenu(languageUser);

    if (response is IdtSuccess<WordsAndMenuImagesModel>) {
      BoxDataSesion.pushToDictionary(dictionary: response.body); //almacenar el dicionario Local
      _route.goHomeFromLanguageSelected(

      );
    } else {
      final erroRes = response as IdtFailure<MenuImagesError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }
}
