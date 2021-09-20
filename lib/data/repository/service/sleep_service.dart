import 'dart:convert';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/response/places_response.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';

import 'package:bogota_app/utils/errors/sleep_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;

class SleepService {
  Future<IdtResult<List<DataModel>?>> getPlacesSleep(String lanUser) async {

    var queryParameters = {
      'lan': lanUser,
    };
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/hotel',queryParameters);

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          {
            final entity = PlacesResponse.fromJson(body);
            return IdtResult.success(entity.data);
          }

        default:
          {
            final error =
            SleepError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = SleepError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }

  Future<IdtResult<DataPlacesDetailModel?>> getSleepSocialById(String id) async {
    final uri = Uri.https(IdtConstants.url_server, '/hotel/' +id,);
    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);
      switch (response.statusCode) {
        case 200: {
          print('service Social SLEEP 200 ok, id: '+ id);
          final entity = ResponseDetailModel.fromJson(body);
          return IdtResult.success(entity.data);
        }

        default: {
          final error = SleepError('Capturar el error', response.statusCode);

          return IdtResult.failure(error);
        }
      }

    } on StateError catch (err) {
      final error = SleepError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }
}
