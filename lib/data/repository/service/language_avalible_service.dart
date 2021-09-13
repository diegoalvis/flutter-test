import 'dart:async';
import 'dart:convert';

import 'package:bogota_app/data/model/language_model.dart';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/response_language_avalible_model.dart';
import 'package:bogota_app/utils/errors/language_avalible_error.dart';
import 'package:bogota_app/utils/idt_result.dart';

import 'package:http/http.dart' as http;

class LanguageAvalibleService {
  Future<IdtResult<List<LanguageModel>?>> getLanguageAvalible() async {

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/util/available_languages');

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          {
            final entity = ResponseLanguageAvalibleModel.fromJson(body);
            return IdtResult.success(entity.data);
          }

        default:
          {
            final error =
            LanguageAvalibleError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = LanguageAvalibleError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }
}
