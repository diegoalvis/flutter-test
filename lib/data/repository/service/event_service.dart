import 'dart:convert';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/response_model.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';

import 'package:bogota_app/utils/errors/event_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;

class EventService {
  Future<IdtResult<List<DataModel>?>> getPlacesEvent(String lanUser) async {
    var queryParameters = {
      'lan': lanUser,
    };
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/event',queryParameters);

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
            final error =
                EventError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = EventError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }
  Future<IdtResult<List<DataModel>?>> getEventCloseToMe(String coordinates,String lanUser) async {
    var queryParameters = {
      'lan': lanUser,
      'location': coordinates,

    };
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/event',queryParameters);

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
            final error =
            EventError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = EventError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }


  Future<IdtResult<DataPlacesDetailModel?>> getEventSocialById(String id, String lanUser) async {
    var queryParameters = {
      'lan': lanUser,
    };
    final uri = Uri.https(IdtConstants.url_server, '/event/' +id,queryParameters);

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);
      switch (response.statusCode) {
        case 200: {
          final entity = ResponseDetailModel.fromJson(body);
          print('service Social EVENT 200 ok, id: '+ id);
          return IdtResult.success(entity.data);
        }

        default: {
          final error = EventError('Capturar el error', response.statusCode);

          return IdtResult.failure(error);
        }
      }

    } on StateError catch (err) {
      final error = EventError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }

  }

}
