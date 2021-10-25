import 'dart:convert';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/response/places_response.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';
import 'package:bogota_app/data/model/response_model.dart';

import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;

class EatService {
  Future<IdtResult<List<DataModel>?>> getPlacesEat(String lanUser) async {
    var queryParameters = {
      'lan': lanUser,
    };
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/food', queryParameters);

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
                UnmissableError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = UnmissableError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }

  Future<IdtResult<List<DataModel>?>> getEatCloseToMe(
      String coordinates, String lanUser) async {
    var queryParameters = {
      'lan': lanUser,
      'location': coordinates,
    };
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/food', queryParameters);

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          {
            final entity = ResponseModel.fromJson(body);
            return IdtResult.success(entity.data);
          }

        default:
          {
            final error = EatError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = EatError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }

  Future<IdtResult<DataPlacesDetailModel?>> getEatSocialById(
      String id, String languageUser) async {
    var queryParameters = {
      'lan': languageUser,
    };
    final uri =
        Uri.https(IdtConstants.url_server, '/food/' + id, queryParameters);

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            final entity = ResponseDetailModel.fromJson(body);
            print('service Social EAT 200 ok, id: ' + id);
            return IdtResult.success(entity.data);
          }

        default:
          {
            final error = EatError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = EatError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }
}
