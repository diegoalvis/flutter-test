import 'package:bogota_app/api/model/data_places_model.dart';
import 'package:bogota_app/api/repository/service/filter_service.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/utils/idt_result.dart';

class ApiInteractor {

  Future<IdtResult<List<DataPlacesModel>?>> getPlacesList() async {

    final response = await locator<FilterService>().getPlaces();

    return response;
  }
}