

import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_as_message_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/favorite_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/language_model.dart';
import 'package:bogota_app/data/model/menu_images_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/request/login_request.dart';
import 'package:bogota_app/data/model/request/register_request.dart';
import 'package:bogota_app/data/model/response_model_reset_password.dart';
import 'package:bogota_app/data/model/splash_model.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/data/repository/service/filter_service.dart';
import 'package:bogota_app/utils/idt_result.dart';


import 'service/audioguide_service.dart';
import 'service/bestRated_service.dart';
import 'service/eat_service.dart';
import 'service/event_service.dart';
import 'service/favorite_service.dart';
import 'service/gps_service.dart';
import 'service/language_avalible_service.dart';
import 'service/login_service.dart';
import 'service/menu_images_service.dart';
import 'service/register_service.dart';
import 'service/reset_password.dart';
import 'service/savedPlaces_service.dart';
import 'service/search_service.dart';
import 'service/sleep_service.dart';
import 'service/splash_service.dart';
import 'service/unmissable_service.dart';
import 'service/zone_service.dart';

class ApiInteractor {
  Future<IdtResult<List<DataModel>?>> getPlacesList(Map params, Map? oldFilters) async {
    final response = await locator<FilterService>().getPlaces(params, oldFilters);

    return response;
  }

  Future<IdtResult<List<DataModel>?>> getPlacesSubcategory(String id) async {
    final response = await locator<FilterService>().getPlaceSubcategories(id);

    return response;
  }

  Future<IdtResult<List<DataModel>?>> getPlaceEventForLocation(Map params, String section) async {
    final response = await locator<FilterService>().getPlaceEventForLocation(params, section);

    return response;
  }

  Future<IdtResult<List<DataModel>?>> getCategoriesList() async {
    final response = await locator<FilterService>().getCategories();

    return response;
  }

  Future<IdtResult<List<DataModel>?>> getSubcategoriesList() async {
    final response = await locator<FilterService>().getSubcategories();

    return response;
  }

  // Future<IdtResult<List<DataModel>?>> getZoneList() async {
  //   final response = await locator<FilterService>().getZones();
  //
  //   return response;
  // }

  Future<IdtResult<List<DataModel>?>> getZonesList() async {
    final response = await locator<ZonesService>().getZones();

    return response;
  }

  Future<IdtResult<List<DataModel>?>> getUnmissablePlacesList() async {
    final response = await locator<UnmissableService>().getUnmissablePlaces();
    return response;
  }

  Future<IdtResult<UserModel?>> getDataUser(String id) async {
    final response = await locator<RegisterService>().getDataUser(id);
    return response;
  }

  Future<IdtResult<List<DataModel>?>> getEventPlacesList() async {
    final response = await locator<EventService>().getPlacesEvent();
    return response;
  }

  Future<IdtResult<List<DataModel>?>> getSleepPlacesList() async {
    final response = await locator<SleepService>().getPlacesSleep();
    return response;
  }

  Future<IdtResult<List<DataModel>?>> getEatPlacesList() async {
    final response = await locator<EatService>().getPlacesEat();
    return response;
  }

  Future<IdtResult<List<DataModel>?>> getSearchResultList(Map params) async {
    final response = await locator<SearchService>().getResultByWord(params);
    return response;
  }

  Future<IdtResult<List<DataModel>?>> getBestRatedPlacesList() async {
    final response = await locator<BestRatedService>().getBestRated();
    return response;
  }

  Future<IdtResult<List<DataAudioGuideModel>?>> getSavedPlacesList() async {
    final response = await locator<SavedPlacesService>().getSavedPlaces();
    return response;
  }

  Future<IdtResult<SplashModel>> getSplashInteractor() async {
    final response = await locator<SplashService>().getSplash();

    return response;
  }

  Future<IdtResult<List<LanguageModel>?>> getLanguageAvalible() async {

    final response = await locator<LanguageAvalibleService>().getLanguageAvalible();
    return response;
  }

  Future<IdtResult<MenuImagesModel>> getImagesMenu() async {
    final response = await locator<MenuImagesService>().getMenuImages();

    return response;
  }

  Future<IdtResult<List<DataAudioGuideModel>?>> getAudioGuidesList() async {
    final response = await locator<AudioGuideService>().getAudioGuide();

    return response;
  }

  Future<IdtResult<DataPlacesDetailModel?>> getPlaceById(String id) async {
    final response = await locator<FilterService>().getPlaceById(id);
    return response;
  }


  Future<IdtResult<FavoriteModel?>> postFavorite(String idplace) async {
    final response = await locator<FavoriteService>().postFavorite(idplace);
    return response;
  }


  Future<IdtResult<DataPlacesDetailModel?>> getEventSocialById(String id) async {
    final response = await locator<EventService>().getEventSocialById(id);
    return response;
  }

  Future<IdtResult<DataPlacesDetailModel?>> getSleepSocialById(
      String id) async {
    final response = await locator<SleepService>().getSleepSocialById(id);
    return response;
  }

  Future<IdtResult<DataPlacesDetailModel?>> getEatSocialById(String id) async {
    final response = await locator<EatService>().getEatSocialById(id);
    return response;
  }

  Future<IdtResult<GpsModel?>> postLocationUser(GpsModel gpsModel) async {
    final response = await locator<GpsService>().setLocationUser(gpsModel);

    return response;
  }

  Future<IdtResult<RegisterModel?>> login(LoginRequest params) async {
    print('entra al future del login');
    final response = await locator<LoginService>().postLogin(params);

    return response;
  }

  Future<IdtResult<RegisterModel?>> register(RegisterRequest params) async {
    final response = await locator<RegisterService>().postRegister(params);

    return response;
  }

  Future<IdtResult<ResponseResetPasswordModel?>> resetPassword(
      String email) async {
    final response = await locator<ResetPasswordService>().resetPassword(email);
    return response;
  }

  Future<IdtResult<DataAsMessageModel?>> deleteUser(
      int id) async {
    final response = await locator<RegisterService>().deleteUser(id);
    return response;
  }

/*  Future<IdtResult<List<DataPlacesModel>?>> getAudioGuidePlacesList() async {
    final response = await locator<AudioGuideService>().getPlacesAudio();

    return response;
  }*/

}

/// class PlaceRepository {
///
///  Future<IdtResult<List<DataPlacesModel>?>> getPlacesList() async {
///
///     final response = await locator<FilterService>().getPlaces();
///
///     return response;
///   }
///
///  ejemplo
///  Future<IdtResult<DataPlacesModel>>> getPlace(String searchQuery) async {
///    todo implement
///     final response = await locator<FilterService>().getPlace(searchQuery;
///
///     return response;
///    }
/// }
///
///
///class SplashRepository {
///  Future<IdtResult<SplashModel>> getSplashInteractor() async {
///
///     final response = await locator<SplashService>().getSplash();
///
///     return response;
///   }
/// }
