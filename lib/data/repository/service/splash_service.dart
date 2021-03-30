import 'dart:convert';

import 'package:bogota_app/data/model/response/splash_response.dart';
import 'package:bogota_app/data/model/splash_model.dart';


import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';

import 'package:http/http.dart' as http;


class SplashService {
  Future<IdtResult<SplashModel>> getSplash() async {
    final uri = Uri.https(IdtConstants.url_server, '/util/splash');

    final response = await http.get(uri);

    try {
      switch (response.statusCode) {
        case 200:
          {
            final body = json.decode(response.body);
            final entity = SplashResponse.fromJson(body);

            return IdtResult.success(entity.data);
          }

        default:
          {
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
