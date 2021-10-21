import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/result_search/result_search_page.dart';
import 'package:bogota_app/pages/result_search/result_search_status.dart';
import 'package:bogota_app/pages/search/search_page.dart';
import 'package:bogota_app/utils/errors/search_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:googleapis/deploymentmanager/v2.dart';
import 'package:googleapis/docs/v1.dart';



enum TypeItem {  Atractivo, Evento, }

class ResultSearchViewModel extends ViewModel<ResultSearchStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;
  final String languageUser = BoxDataSesion.getLaguageByUser();

  ResultSearchViewModel(this._route, this._interactor) {
    status = ResultSearchStatus(isLoading: true, openMenu: false);
  }

  void onInit() async {
    //TODO
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }


  void goDetailPage(String id, String type) async {

    status = status.copyWith(isLoading: true);
    print(id);
    //TODO: Valida navegacion cuando es un evento o un atractivo, crear enum
    IdtResult<DataPlacesDetailModel?> placebyidResponse;



    if (type == "Atractivos") {
      placebyidResponse = await _interactor.getPlaceById(id, languageUser); //Atractivo
    } else {
      placebyidResponse = await _interactor.getEventSocialById(id, languageUser); //Eventos
    }

    if (placebyidResponse is IdtSuccess<DataPlacesDetailModel?>) {
      if (type == 'Atractivos') {
        _route.goDetail(isHotel: false, detail: placebyidResponse.body!);
      } else if (type == 'Eventos') {
        _route.goEventDetail(detail: placebyidResponse.body!); //Eventos
      }
    } else {
      final erroRes = placebyidResponse as IdtFailure<SearchError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  Future<bool> offMenuBack() async {
    bool? shouldPop = true;

    if (status.openMenu) {
      status = status.copyWith(openMenu: false);
      openMenu();
      return !shouldPop;
    } else {
      IdtRoute.route = SearchPage.namePage;
      return shouldPop;
    }
  }
}
