import 'dart:io';

import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/audios_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/favorite_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/detail/detail_effect.dart';
import 'package:bogota_app/pages/detail/detail_status.dart';
import 'package:bogota_app/pages/discover/discover_page.dart';
import 'package:bogota_app/pages/result_search/result_search_page.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailViewModel extends EffectsViewModel<DetailStatus, DetailEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  late String languageUser;

  DetailViewModel(this._route, this._interactor) {
    status = DetailStatus(
      isLoading: true,
      isFavorite: false,
      moreText: false,
    );
  }

  void readMore() {
    final bool tapClick = status.moreText;
    status = status.copyWith(moreText: !tapClick);
  }

  void goPlayAudioPage(AudiosModel _detail) {
    status = status.copyWith(isLoading: true);
    // _route.goPlayAudio(detail: _detail);
    _route.goNewPlayAudio(detail: _detail);
  }

  onTapFavorite(String idplace) async {
    late bool value = status.isFavorite;
    print("idplace");
    print(idplace);
    final favoriteResponse = await _interactor.postFavorite(idplace);
    if (favoriteResponse is IdtSuccess<FavoriteModel?>) {
      print("model detail");
      print(favoriteResponse.body!.message);
      // _route.goDetail(isHotel: false, detail: placebyidResponse.body!);
      /// Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    }
    /* else {
      final erroRes = placebyidResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }*/
    status = status.copyWith(isLoading: false);

    status = status.copyWith(isFavorite: !value);
    print("boll value favorite");
    print(status.isFavorite);
  }

  Future<bool> isFavorite(String id) async {
    languageUser = BoxDataSesion.getLaguageByUser(); //get language User Prefered

    bool isFavorite = false;
    // Actualización de lugares guardados/favoritos
    final dynamic savedPlaces = await _interactor.getSavedPlacesList(languageUser);
    if (savedPlaces is IdtSuccess<List<DataAudioGuideModel>?>) {
      List places = savedPlaces.body!;

      try {
        final DataAudioGuideModel lugarIsFavoriteSaved =
            places.firstWhere((element) => element.id == id);
        if (lugarIsFavoriteSaved != null) {
          isFavorite = true;
        }
      } catch (e) {
        isFavorite = false;
      }
    }
    return isFavorite;
  }

  void onChangeScrollController(int duration,bool value, double width) {
    addEffect(DetailControllerScrollEffect(duration, width, value));
  }

  void launchCall(String phone) async {
    print('Llamando desde el Boton,');
    launch("tel: $phone");
    if (Platform.isIOS) print('Verificar si marca desde un dispositivo real');
  }

  Future<String> launchPageWeb(String urlPage) async {
    String newUrl = '';

    print('Abriendo pagina del Hotel, $urlPage');
    if (urlPage[0] == 'w') {
      launch('http://$urlPage');
      print('Sin protocolo');
      newUrl = urlPage;
      print(newUrl);
    } else {
      print('Con protocolo');
      launch(urlPage);
      newUrl = urlPage.substring(8);
      print(newUrl);
    }
    return newUrl;
  }

  void launchMap(String location) async {
    print('Abriendo Map del Detalle');
    String longitude = location.split(", ").first;
    String latitude = location.split(", ").last;
    final double lat = double.parse(latitude);
    final double lon = double.parse(longitude);
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    await launch(url);

  }
  pushPlaceVisitedStorageLocal(DataPlacesDetailModel placeNew) async {
    try {
      List<dynamic> list = [];
      CurrentUser? user = BoxDataSesion.getCurrentUser()!;
      if (user.id_user != null) {
        list = BoxDataSesion.getListActivity(user.id_user!);
        // buscar el lugar a ver si ya antes estaba, para removerlo y ponerlo de primero
        final index = list.indexWhere((element) => element.id == placeNew.id);
        if (index != -1) {
          print("Ya existia, se reacomoda lugar en posición 🤷‍♂️");
          list.removeAt(index);
          list.add(placeNew);
        } else {
          // Si ya esta lleno max=30, entonces remueve el primer elemento agregado,  y se suma el nuevo favorito
          // de primero
          if (list.length == 30) {
            list.removeAt(0);
          }
          list.add(placeNew);
        }

        BoxDataSesion.pushToActivity(user.id_user!, list);
      }
    } catch (e) {}
  }

  bool validationEmptyResponse(String? resourse) {
    return resourse != '' && resourse != null;
  }

  Future<bool> offMenuBack() async {
    bool? shouldPop = true;
    IdtRoute.route = DiscoverPage.namePage;
    return shouldPop;
  }

  dialogSuggestionLoginSavedPlace(){
    addEffect(ShowDialogAddSavedPlaceEffect());
  }
}
