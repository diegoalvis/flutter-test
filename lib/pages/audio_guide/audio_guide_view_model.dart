import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/audios_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/favorite_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/audio_guide/audio_guide_status.dart';
import 'package:bogota_app/pages/audio_guide/audio_guides_effect.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/errors/zones_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';


class AudioGuideViewModel extends EffectsViewModel<AudioGuideStatus, AudioGuidesEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  late String languageUser;

  AudioGuideViewModel(this._route, this._interactor) {
    status = AudioGuideStatus(
      nameFilter: 'Localidad',
      isLoading: true,
      openMenu: false,
      openMenuTab: false,
      itemsAudioGuide: [],
      zones: [],
    );
  }

  void onInit() async {
    status = status.copyWith(isLoading: true);
    getZonesResponse();
    getAudioGuideResponse();
  }

  void getZonesResponse() async {
    status = status.copyWith(isLoading: true);
    languageUser =
        BoxDataSesion.getLaguageByUser(); //get language User Prefered

    final zonesResponse = await _interactor.getZonesList(languageUser);

    if (zonesResponse is IdtSuccess<List<DataModel>?>) {
      status =
          status.copyWith(zones: zonesResponse.body); // Status reasignacion
    } else {
      final erroRes = ZonesError as IdtFailure<ZonesError>;
      print(erroRes.message);
      UnimplementedError();
    }
  }

  void getAudioGuideResponse() async {
    languageUser =
        BoxDataSesion.getLaguageByUser(); //get language User Prefered
    final audioguideResponse =
        await _interactor.getAudioGuidesList(languageUser);
    if (audioguideResponse is IdtSuccess<List<DataAudioGuideModel>?>) {
      print(audioguideResponse.body![0].audioguia_en);
      status = status.copyWith(
          itemsAudioGuide: audioguideResponse.body, isLoading: false);

      // Actualización de lugares guardados/favoritos
      final dynamic savedPlaces =
          await _interactor.getSavedPlacesList(languageUser);
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

  void openMenuTab(
      List<DataModel> listData,
      // String section, int currentOption
      ) {
    status = status.copyWith(
      openMenuTab: !status.openMenuTab,
      zones: listData,
      // section: section,
      // currentOption: currentOption,
    );
  }
  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false);
  }

  void filtersForZones(DataModel item,) async {
    status = status.copyWith(isLoading: true);
    languageUser = BoxDataSesion.getLaguageByUser(); //get language User Prefered

    final Map query = {'zone' : item.id};

    final response = await _interactor.getAudioGuidesForLocation(query, languageUser);
    if (response is IdtSuccess<List<DataAudioGuideModel>?>) {
      status = status.copyWith(itemsAudioGuide: response.body,nameFilter: item.title!); // Status reasignacion

    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    closeMenuTab();
    status = status.copyWith(isLoading: false);
    if (status.itemsAudioGuide.length < 1) {
      addEffect(ShowDialogEffect());
    }
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
    languageUser =
        BoxDataSesion.getLaguageByUser(); //get language User Prefered

    final placebyidResponse = await _interactor.getAudiosById(id, languageUser);

    if (placebyidResponse is IdtSuccess<AudiosModel?>) {
      _route.goDetailAudio(isHotel: false, detail: placebyidResponse.body!);

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
