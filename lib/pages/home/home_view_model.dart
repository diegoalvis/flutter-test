import 'dart:async';

import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/menu_images_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/home/home_effect.dart';
import 'package:bogota_app/pages/home/home_status.dart';
import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/errors/menu_images_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  late String languageUser;

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
        itemsSavedPlaces: [],
        itemAudiosSavedPlaces: [],
        listBoolAudio: [],
        listBoolAll: [],
        message: '');
  }

  void onInit() async {
    status = status.copyWith(isLoading: true);
    getUnmissableResponse();
    // getEatResponse();
    getBestRatedResponse();
    getWordsAndImagesMenu();

    onpenSavedPlaces();
    if (status.itemsSavedPlaces.length >= 1) {
      status.notSaved = false;
    }
  }

  void getWordsAndImagesMenu() async {
    languageUser =
        BoxDataSesion.getLaguageByUser();
    final response = await _interactor.getWordsAndImagesMenu(languageUser);

    if (response is IdtSuccess<MenuImagesModel>) {
      status = status.copyWith(imagesMenu: response.body.images_menu);
    } else {
      final erroRes = response as IdtFailure<MenuImagesError>;
      print(erroRes.message);
      UnimplementedError();
    }
  }

  void getUnmissableResponse() async {
    languageUser = BoxDataSesion.getLaguageByUser(); //get language User Prefered
    final unmissableResponse = await _interactor.getUnmissablePlacesList(languageUser);

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

  void getBestRatedResponse() async {
    languageUser = BoxDataSesion.getLaguageByUser(); //get language User Prefered
    final bestRatedResponse = await _interactor.getBestRatedPlacesList(languageUser);

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
    languageUser = BoxDataSesion.getLaguageByUser(); //get language User Prefered

    final savedResponse = await _interactor.getSavedPlacesList(languageUser);

    if (savedResponse is IdtSuccess<List<DataAudioGuideModel>?>) {
      if (savedResponse.body!.length > 0) {
        //hay lugares guardados
        status = status.copyWith(notSaved: false);
      }
      // Se recupera y se filtra los itemsSavedPlaces
      List<DataAudioGuideModel>? listSavedPlacesFilter = savedResponse.body ?? [];
      listSavedPlacesFilter = removeRepeatElementById(listSavedPlacesFilter);
      status = status.copyWith(itemsSavedPlaces: listSavedPlacesFilter); // Status reasignacion

      // Se recupera y se filtra los itemAudiosSavedPlaces
      List<DataAudioGuideModel> listAudiosSavedPlacesFilter1 = savedResponse.body!
          .where((f) => (f.audioguia_es != null && f.audioguia_es != '' ||
              f.audioguia_en != null && f.audioguia_en != '' ||
              f.audioguia_pt != null && f.audioguia_pt != ''))
          .toList();
      listAudiosSavedPlacesFilter1 = removeRepeatElementById(listAudiosSavedPlacesFilter1);
      status = status.copyWith(itemAudiosSavedPlaces: listAudiosSavedPlacesFilter1); //filtro audios

      List<bool> listAudio = [];
      List<bool> listAll = [];
      for (final f in savedResponse.body!) {
        //
        if (f.audioguia_es != null && f.audioguia_es != '' ||
            f.audioguia_en != null && f.audioguia_en != '' ||
            f.audioguia_pt != null && f.audioguia_pt != '') {
          listAudio.add(true);
          print(listAudio);
          listAll.add(true);
        } else {
          listAll.add(false);
        }
      }
      status = status.copyWith(listBoolAudio: listAudio); //filtro audios
      status = status.copyWith(listBoolAll: listAll);
    } else {
      final erroRes = savedResponse as IdtFailure<EatError>;
      print(erroRes.message);
      UnimplementedError();
      // FoodError();
      //Todo implementar errores
    }
    status = status.copyWith(isLoading: false);

    // addEffect(ShowDialogEffect('nada'));  //Dialog de prueba
  }

  List<DataAudioGuideModel> removeRepeatElementById(List<DataAudioGuideModel> list) {
    final Map<String, DataAudioGuideModel> profileMap = new Map();
    list.forEach((DataAudioGuideModel item) => profileMap["${item.id}"] = item);
    list = profileMap.values.toList();
    return list;
  }

  addSavedPLaces() async {
    //onpenSavedPlaces();
    if (status.itemsSavedPlaces.length < 1) {
      addEffect(ShowDialogSavedPlacedEffect());
    }
    status = status.copyWith(notSaved: true);
  }

  suggestionLogin() {
    addEffect(ShowDialogSuggestionLoginEffect());
  }

  void onTapSeeAll(bool value) {
    status = status.copyWith(seeAll: value);
  }

  void onChangeScrollController(bool value) {
    addEffect(HomeValueControllerScrollEffect(200, value));
  }

  void goDetailPage(String id) async {
    status = status.copyWith(isLoading: true);
    languageUser = BoxDataSesion.getLaguageByUser(); //get language User Prefered

    final placebyidResponse = await _interactor.getPlaceById(id, languageUser);
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

  Future<bool> offMenuBack() async {
    bool? shouldPop = true;

    if (status.openMenu) {
      openMenu();
      return !shouldPop;
    } else {
      return shouldPop;
    }
  }

  void goDiscoverPage() {
    _route.goDiscover();
  }
}
