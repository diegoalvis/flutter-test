import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/favorite_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/audio_guide/audio_guide_status.dart';
import 'package:bogota_app/pages/discover/discover_page.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter/cupertino.dart';

class AudioGuideViewModel extends ViewModel<AudioGuideStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  late String languageUser;

  AudioGuideViewModel(this._route, this._interactor) {
    status =
        AudioGuideStatus(isLoading: true, openMenu: false, itemsAudioGuide: []);
  }

  void onInit() async {
    status = status.copyWith(isLoading: true);
    getAudioGuideResponse();
  }

  void getAudioGuideResponse() async {
    languageUser = BoxDataSesion.getLaguageByUser();
    // if(languageUser == 'es'){
    //   languageUser= 'en';
    // };
    final audioguideResponse =
        await _interactor.getAudioGuidesList(languageUser);
    if (audioguideResponse is IdtSuccess<List<DataAudioGuideModel>?>) {
      print(audioguideResponse.body![0].audioguia_en);
      status = status.copyWith(
          itemsAudioGuide: audioguideResponse.body, isLoading: false);

      // Actualización de lugares guardados/favoritos
      final dynamic savedPlaces = await _interactor.getSavedPlacesList();
      if (savedPlaces is IdtSuccess<List<DataAudioGuideModel>?>) {
        List places = savedPlaces.body!;
        audioguideResponse.body!.map((audioguide) {
          try {
            final DataAudioGuideModel lugarIsFavoriteSaved =
                places.firstWhere((element) => element.id == audioguide.id);
            if (lugarIsFavoriteSaved != null) {
              audioguide.isFavorite = true;
            }
          } catch (e) {
            audioguide.isFavorite = false;
          }
          return audioguide;
        }).toList();
      }
      status = status.copyWith(itemsAudioGuide: audioguideResponse.body);

      /// Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = audioguideResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  goDetailPage(String id) async {
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

  onTapFavorite(String idplace) async {
    print("🔑 idplace");
    print(idplace);
    final favoriteResponse = await _interactor.postFavorite(idplace);
    if (favoriteResponse is IdtSuccess<FavoriteModel?>) {
      var list = status.itemsAudioGuide;
      list.forEach((e) {
        if (e.id == idplace) {
          e.isFavorite = e.isFavorite == true ? false : true;
        }
      });
      status = status.copyWith(itemsAudioGuide: list);
    }
    status = status.copyWith(isLoading: false);
  }

  Future<bool> offMenuBack() async {
    bool? shouldPop = true;

    if (status.openMenu) {
      openMenu();
      return !shouldPop;
    } else {
      // IdtRoute.route = DiscoverPage.namePage; Debido a que al volver de audioguia setea el name de discover, lo que no permite navegar desde el Home
      IdtRoute.route = "";
      return shouldPop;
    }
  }
}
