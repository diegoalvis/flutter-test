import 'dart:async';

import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/home/home_effect.dart';
import 'package:bogota_app/pages/home/home_status.dart';
import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
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
      titleBar: 'Recibidos',
      isLoading: false,
      openMenu: false,
      openSaved: true,
      notSaved: true,
      seeAll: true,
      itemsUnmissablePlaces: [],
      itemsEatPlaces: [],
    );
  }

  void onInit() async {
    status = status.copyWith(isLoading: true);
    getUnmissableResponse();
    getEatResponse();
    Timer.periodic(Duration(seconds: 5), (timer) {
      _init();
      print(DateTime.now());
      getLoc();
    });

  }


  getLoc() async{
    Location location = Location();
    LocationData _currentPosition;
    String _address,_dateTime;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    print(_currentPosition);
  }


  Future<void> _init() async {
    String? adId;
    String? uuid;

    try {
      uuid = await UniqueIds.uuid;
    } on PlatformException {
      uuid = 'Failed to create uuid.v1';
    }

    try {
      adId = await UniqueIds.adId;
    } on PlatformException {
      adId = 'Failed to get adId version.';
    }

    print(uuid);
  }

  void getUnmissableResponse() async {
    final unmissableResponse = await _interactor.getUnmissablePlacesList();

    if (unmissableResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(itemsUnmissablePlaces: unmissableResponse.body); // Status reasignacion
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
      status = status.copyWith(
          itemsEatPlaces: eatResponse.body); // Status reasignacion
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
