import 'dart:async';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/menu_images_model.dart';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/home/home_effect.dart';
import 'package:bogota_app/pages/home/home_status.dart';
import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/errors/menu_images_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/errors/user_data_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:unique_ids/unique_ids.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  HomeViewModel(this._route, this._interactor) {
    status = HomeStatus(
      imagesMenu: [],
      titleBar: 'Recibidos',
      isLoading: false,
      openMenu: false,
      openSaved: true,
      notSaved: true,
      seeAll: true,
      itemsUnmissablePlaces: [],
      itemsEatPlaces: [],
      itemsbestRatedPlaces: [],
      itemsSavedPlaces: []
    );
  }


  void onInit() async {
    status = status.copyWith(isLoading: true);
    getUnmissableResponse();
    // getEatResponse();
    getBestRatedResponse();
    getImagesMenu();

  }

  void getImagesMenu() async {
    final response = await _interactor.getImagesMenu();

    if (response is IdtSuccess<MenuImagesModel>) {
      status = status.copyWith(imagesMenu: response.body.menu);

    } else {

      final erroRes = response as IdtFailure<MenuImagesError>;
      print(erroRes.message);
      UnimplementedError();
    }
  }


  void getUnmissableResponse() async {
    final unmissableResponse = await _interactor.getUnmissablePlacesList();

    if (unmissableResponse is IdtSuccess<List<DataModel>?>) {
      status =
          status.copyWith(itemsUnmissablePlaces: unmissableResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = unmissableResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void getEatResponse() async {
    final eatResponse = await _interactor.getEatPlacesList();

    if (eatResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(itemsEatPlaces: eatResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = eatResponse as IdtFailure<EatError>;
      print(erroRes.message);
      UnimplementedError();
      // FoodError();
      //Todo implementar errores
    }
    status = status.copyWith(isLoading: false);
  }

  void getBestRatedResponse() async {
    final bestRatedResponse = await _interactor.getBestRatedPlacesList();

    if (bestRatedResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(itemsbestRatedPlaces: bestRatedResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = bestRatedResponse as IdtFailure<EatError>;
      print(erroRes.message);
      UnimplementedError();
      // FoodError();
      //Todo implementar errores
    }
    status = status.copyWith(isLoading: false);
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);

  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onpenSavedPlaces() async {
    print('se abre lugares guardados');
    final bool value = status.openSaved;
    status = status.copyWith(openSaved: !value);

    final savedResponse = await _interactor.getSavedPlacesList();

    if (savedResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(itemsSavedPlaces: savedResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = savedResponse as IdtFailure<EatError>;
      print(erroRes.message);
      UnimplementedError();
      // FoodError();
      //Todo implementar errores
    }
    status = status.copyWith(isLoading: false);


    //addEffect(ShowDialogEffect());  Dialog de prueba
  }

  void addSavedPLaces() {
    print('se muestran lugares guardados');
    onpenSavedPlaces();
    status = status.copyWith(notSaved: false);

  }

  void onTapSeeAll(bool value) {
    status = status.copyWith(seeAll: value);
  }

  void onChangeScrollController(bool value) {
    addEffect(HomeValueControllerScrollEffect(300, value));
  }
 void goDetailPage(String id) async {
   status = status.copyWith(isLoading: true);

   final placebyidResponse = await _interactor.getPlaceById(id);
   print('view model detail page');
   print(placebyidResponse);
   if (placebyidResponse is IdtSuccess<DataPlacesDetailModel?>) {
     print("model detail");
     print(placebyidResponse.body!.title);
     _route.goDetail(isHotel: false, detail: placebyidResponse.body!);
     /// Status reasignacion
     // status.places.addAll(UnmissableResponse.body)
   } else {
     final erroRes = placebyidResponse as IdtFailure<UnmissableError>;
     print(erroRes.message);
     UnimplementedError();
   }
   status = status.copyWith(isLoading: false);

  }

  void setLocationUser() async {
    final GpsModel location =
        GpsModel(imei: '999', longitud: '-78.229', latitud: '2.3666', fecha: '03/19/21');
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
