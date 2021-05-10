import 'dart:convert';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/request/login_request.dart';
import 'package:bogota_app/data/model/response/places_response.dart';
import 'package:bogota_app/data/model/response/register_response.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<IdtResult<RegisterModel?>>  postLogin(LoginRequest params) async {

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/auth/login');

    final response = await http.post(uri, body: params.toJson() );

    try {
      final body = json.decode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            final entity = RegisterResponse.fromJson(body);
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
}
