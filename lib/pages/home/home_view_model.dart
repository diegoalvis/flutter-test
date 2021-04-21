import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/places_model.dart';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/home/home_effect.dart';
import 'package:bogota_app/pages/home/home_status.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/errors/food_error.dart';
import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
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
      seeAll: true,
      itemsUnmissablePlaces: [],
      itemsFoodPlaces: [],
    );
  }

  void onInit() async {
    status = status.copyWith(isLoading: true);
    getUnmissableResponse();
    getFoodResponse();
  }

  void getUnmissableResponse() async {
    final unmissableResponse = await _interactor.getUnmissablePlacesList();

    if (unmissableResponse is IdtSuccess<List<DataPlacesModel>?>) {
      status = status.copyWith(itemsUnmissablePlaces: unmissableResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = unmissableResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void getFoodResponse() async {
    final foodResponse = await _interactor.getFoodPlacesList();

    if (foodResponse is IdtSuccess<List<DataPlacesModel>?>) {
      status = status.copyWith(
          itemsFoodPlaces: foodResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = foodResponse as IdtFailure<FoodError>;
      print(erroRes.message);
      UnimplementedError();
      // FoodError();
      //Todo implementar errores
    }
    status = status.copyWith(isLoading: false);
  }


  void onpenMenu() {
    if (status.openMenu==false){
    status = status.copyWith (openMenu: true);
    }
    else{
      status = status.copyWith(openMenu: false);
    }
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onpenSavedPlaces() {
    final bool value = status.openSaved;
    status = status.copyWith(openSaved: !value);

    //addEffect(ShowDialogEffect());  Dialog de prueba
  }

  void addSavedPLaces() {
    status = status.copyWith(notSaved: false);
  }

  void onTapSeeAll(bool value) {
    status = status.copyWith(seeAll: value);
  }

  void onChangeScrollController(bool value) {
    addEffect(HomeValueControllerScrollEffect(300, value));
  }

  void goDetailPage() {
   // _route.goDetail(isHotel: false);
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
