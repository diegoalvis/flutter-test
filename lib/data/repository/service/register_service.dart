import 'dart:convert';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/request/register_request.dart';
import 'package:bogota_app/data/model/response/places_response.dart';
import 'package:bogota_app/data/model/response/register_response.dart';
import 'package:bogota_app/data/model/response_user_model.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;

//user_service
class RegisterService {
  Future<IdtResult<RegisterModel?>>  postRegister(RegisterRequest params) async {
    print('se imprimen parámetros en el servicio');
    print(params.toJson());

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/user');

    final response = await http.post(uri, body: params.toJson() );

    try {
      final body = json.decode(response.body);
      print("response.statusCode");
      print(response.statusCode);
      switch (response.statusCode) {
        case 201:
          {
            final entity = RegisterResponse.fromJson(body);
            return IdtResult.success(entity.data);
          }

        default:
          {
            print(response.body);
            final error =
            //Todo registerError?
            UnmissableError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = UnmissableError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }

  Future<IdtResult<UserModel?>>  getDataUser(String id) async {
    final uri = Uri.https(IdtConstants.url_server, '/user/'+id);
    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);
      print('Status *getDatUser: ${response.statusCode}');
      print('body *getDatUser: ${response.body}');
      switch (response.statusCode) {
        case 200:
          {
            final entity = ResponseUserModel.fromJson(body);
            return IdtResult.success(entity.data);
          }

        default:
          {
            print(response.body);
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
