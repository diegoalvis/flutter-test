import 'dart:convert';

import 'package:bogota_app/api/model/data_places_model.dart';
import 'package:bogota_app/api/model/response_places_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';

import 'package:http/http.dart' as http;

class FilterService {

  Future<IdtResult<List<DataPlacesModel>?>> getPlaces() async {

    final queryParameters = {
      'zone': '23'
    };

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/event');

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      print('Response: ${body}');
      print('Response: ${response.statusCode}');

      switch (response.statusCode) {
        case 200: {
          final entity = ResponsePlacesModel.fromJson(body);

          return IdtResult.success(entity.data);
        }

        default: {
          final error = FilterError('Capturar el error', response.statusCode);

          return IdtResult.failure(error);
        }
      }

    } on StateError catch (err) {
      final error = FilterError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }

  }
}