import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/placesdetail_model.dart';
import 'package:bogota_app/data/model/splash_model.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/data/repository/service/audioguide_service.dart';
import 'package:bogota_app/data/repository/service/event_service.dart';
import 'package:bogota_app/data/repository/service/filter_service.dart';
import 'package:bogota_app/data/repository/service/food_service.dart';
import 'package:bogota_app/data/repository/service/gps_service.dart';
import 'package:bogota_app/data/repository/service/sleep_service.dart';
import 'package:bogota_app/data/repository/service/splash_service.dart';
import 'package:bogota_app/data/repository/service/unmissable_service.dart';
import 'package:bogota_app/utils/idt_result.dart';

class ApiInteractor {

  Future<IdtResult<List<DataModel>?>> getPlacesList(Map params) async {
    final response = await locator<FilterService>().getPlaces(params);

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

  Future<IdtResult<List<DataModel>?>> getZoneList() async {
    final response = await locator<FilterService>().getZones();

    return response;
  }

  Future<IdtResult<List<DataModel>?>> getUnmissablePlacesList() async {
    final response = await locator<UnmissableService>().getUnmissablePlaces();

    return response;
  }

  Future<IdtResult<List<DataModel>?>> getEventPlacesList() async {
    final response = await locator<EventService>().getEvent();

    return response;
  }

  Future<IdtResult<SplashModel>> getSplashInteractor() async {
    final response = await locator<SplashService>().getSplash();

    return response;
  }

  Future<IdtResult<List<DataModel>?>> getFoodPlacesList() async {
    final response = await locator<PlacesFoodService>().getPlacesFood();

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

  Future<IdtResult<List<DataModel>?>> getSleepPlacesList() async {
    final response = await locator<PlacesSleepService>().getPlacesSleep();

    return response;
  }

  Future<IdtResult<GpsModel?>> postLocationUser(GpsModel gpsModel) async {
    final response = await locator<GpsService>().setLocationUser(gpsModel);

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
