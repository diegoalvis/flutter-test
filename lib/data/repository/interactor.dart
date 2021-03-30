import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/data/model/splash_model.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/data/repository/service/filter_service.dart';
import 'package:bogota_app/data/repository/service/food_service.dart';
import 'package:bogota_app/data/repository/service/sleep_service.dart';
import 'package:bogota_app/data/repository/service/splash_service.dart';
import 'package:bogota_app/data/repository/service/unmissable_service.dart';
import 'package:bogota_app/utils/idt_result.dart';

// class Repository
class ApiInteractor {

  Future<IdtResult<List<DataModel>?>> getPlacesList() async {
    final response = await locator<FilterService>().getPlaces();

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

  Future<IdtResult<List<DataPlacesModel>?>> getUnmissablePlacesList() async {
    final response = await locator<UnmissableService>().getPlaces();

    return response;
  }

  Future<IdtResult<SplashModel>> getSplashInteractor() async {
    final response = await locator<SplashService>().getSplash();

    return response;
  }

  Future<IdtResult<List<DataPlacesModel>?>> getFoodPlacesList() async {
    final response = await locator<PlacesFoodService>().getPlacesFood();

    return response;
  }

  Future<IdtResult<List<DataPlacesModel>?>> getSleepPlacesList() async {
    final response = await locator<PlacesSleepService>().getPlacesSleep();

    return response;
  }
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
