import 'package:bogota_app/api/model/data_places_model.dart';
import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/home/home_effect.dart';
import 'package:bogota_app/pages/home/home_status.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  HomeViewModel(this._route, this._interactor) {
    status = HomeStatus(
      titleBar: 'Recibidos',
      isLoading: false,
      openMenu: false,
      openSaved: true,
      notSaved: true,
      seeAll: true
    );
  }

  void onInit() async {
    // TODO
  }

  void onpenMenu() {
    status = status.copyWith(openMenu: true);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onpenSavedPlaces() {

    addEffect(ShowDialogEffect());

    /*final bool value = status.openSaved;
    status = status.copyWith(openSaved: !value);*/
  }

  void addSavedPLaces() {
    status = status.copyWith(notSaved: false);
  }

  void onTapSeeAll(bool value) {
    status = status.copyWith(seeAll: value);
  }

  void onChangeScrollController(bool value){
    addEffect(HomeValueControllerScrollEffect(300, value));
  }

  void goDetailPage() {
    _route.goDetail(isHotel: false);
  }

  void goDiscoverPage() async {

    status = status.copyWith(isLoading: true);

    final response = await _interactor.getPlacesList();

    if(response is IdtSuccess<List<DataPlacesModel>?>){

      print('Respuesta ViewModel: ${response.body![0].title} ');
      _route.goDiscover();
    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

}
