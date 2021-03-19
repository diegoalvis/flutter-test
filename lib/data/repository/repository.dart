import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/data/model/splash_model.dart';
import 'package:bogota_app/data/service/filter_service.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/data/service/splash_service.dart';
import 'package:bogota_app/utils/idt_result.dart';

// class Repository
class PlaceRepository {
  Future<IdtResult<List<DataPlacesModel>?>> getPlacesList() async {
    final response = await locator<FilterService>().getPlaces();

    return response;
  }
}

class SplashRepository {
  Future<IdtResult<SplashModel>> getSplashInteractor() async {
    final response = await locator<SplashService>().getSplash();

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
