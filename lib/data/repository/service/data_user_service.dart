import 'dart:convert';
import 'package:bogota_app/data/model/data_as_message_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/request/login_request.dart';
import 'package:bogota_app/data/model/request/rate_request.dart';
import 'package:bogota_app/data/model/request/register_request.dart';
import 'package:bogota_app/data/model/request/user_data_request.dart';
import 'package:bogota_app/data/model/response/delete_user_response.dart';
import 'package:bogota_app/data/model/response/places_response.dart';
import 'package:bogota_app/data/model/response/register_response.dart';
import 'package:bogota_app/data/model/response/splash_response.dart';
import 'package:bogota_app/data/model/response/user_update_response.dart';
import 'package:bogota_app/data/model/response_user_model.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;

//user_service
class DataUserService {
  Future<IdtResult<RegisterModel?>> postRegister(RegisterRequest params) async {
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/user');

    final response = await http.post(uri, body: params.toJson());

    try {
      final body = json.decode(response.body);
      switch (response.statusCode) {
        case 201:
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

  Future<IdtResult<RegisterModel?>> postLogin(LoginRequest params) async {
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/auth/login');

    final response = await http.post(uri, body: params.toJson());

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

  Future<IdtResult<UserModel?>> getDataUser(String id) async {
    final uri = Uri.https(IdtConstants.url_server, '/user/' + id);
    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

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

  Future<IdtResult<DataAsMessageModel?>> deleteUser(int id) async {
    final uri = Uri.https(IdtConstants.url_server, '/user/$id');
    final response = await http.delete(uri);

    try {
      final body = json.decode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            final entity = DeleteUserResponse.fromJson(body);
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

  Future<IdtResult<UserDataRequest?>> updateUser(String newLastName, String newName,
      String newEmail, String idUser) async {
    final dataUserRequest = UserDataRequest(
      name: newName,
      lastName: newLastName,
      email: newEmail,
    );

    String encodeUserRequest = jsonEncode(dataUserRequest);
    print(encodeUserRequest);
    String url = 'https://${IdtConstants.url_server}/user/$idUser';
    final response = await http.put(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: encodeUserRequest);

    try {
      final body = json.decode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            final entity = UserUpdateResponse.fromJson(body);

            return IdtResult.success(entity.data);
          }

        default:
          {
            //Todo change error
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
