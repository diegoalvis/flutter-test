import 'dart:convert';

import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/data/model/audios_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/response/audios_response.dart';
import 'package:bogota_app/data/model/response_model.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class FilterService {
  late final ApiInteractor _interactor;

  Future<IdtResult<List<DataModel>?>> getPlacesListGoFilter(
      Map<String, String> params, String lanUser) async {
    params["lan"] = lanUser;

    final uri = Uri.https(IdtConstants.url_server, '/place', params);

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
            final error = FilterError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = FilterError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }

  //Este metodo trae los lugares apenas se entra al filter Page
  Future<IdtResult<List<DataModel>?>> getPlaces(Map<String, dynamic> params,
      Map<String, dynamic> oldParams, String lanUser) async {
    // Map<String, dynamic>? queryParameters;

    params['lan'] = lanUser;

    // params.addAll(oldParams);
    //Todo validar cuando es la misma Key
    if (!oldParams.containsKey('subcategory') ) {
      params.addAll(oldParams);
    }

    final uri = Uri.https(IdtConstants.url_server, '/place', params);

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
            final error = FilterError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = FilterError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }


  Future<IdtResult<List<DataModel>?>> getPlaceSubcategories(
      String id, String? lanUser) async {
    Map<String, String>? queryParameters;
    if (lanUser != null) {
      queryParameters = {
        'lan': lanUser,
      };
    }
    final uri = Uri.https(
        IdtConstants.url_server, '/subcategory/' + id, queryParameters);

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);
      print(body);
      switch (response.statusCode) {
        case 200:
          {
            final entity = ResponseModel.fromJson(body);
            print(entity.data);
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

  Future<IdtResult<DataPlacesDetailModel?>> getPlaceById(
      String id, String languageUser) async {
    var queryParameters = {
      'lan': languageUser,
    };

    final uri =
        Uri.https(IdtConstants.url_server, '/place/' + id, queryParameters);

    print("uri");
    print(uri);
    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);
      print(body);
      switch (response.statusCode) {
        case 200:
          {
            final entity = ResponseDetailModel.fromJson(body);
            print(entity.data);
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

  Future<IdtResult<AudiosModel?>> getAudiosById(
      String id, String languageUser) async {
    var queryParameters = {
      'lan': languageUser,
    };

    final uri =
        Uri.https(IdtConstants.url_server, '/audio/' + id, queryParameters);

    print("uri");
    print(uri);
    final response = await http.get(uri);
    print("trae respuest a de audiso");
    print(response.body);
    try {
      final body = json.decode(response.body);
      print(body);
      switch (response.statusCode) {
        case 200:
          {
            final entity = AudiosResponseModel.fromJson(body);
            print("entity.data");
            print(entity.data);
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

  Future<IdtResult<List<DataModel>?>> getCategories(String lanUser) async {
    var queryParameters = {
      'lan': lanUser,
    };
    final uri =
        Uri.https(IdtConstants.url_server, '/category', queryParameters);

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
            final error = FilterError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = FilterError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }

  Future<IdtResult<List<DataModel>?>> getSubcategories(String lanUser) async {
    final queryParameters = {
      'lan': lanUser,
    };
    final uri =
        Uri.https(IdtConstants.url_server, '/subcategory', queryParameters);

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
            final error = FilterError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = FilterError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }

  // Este servicio deberia ser independiente??
  Future<IdtResult<List<DataModel>?>> getZones() async {
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/zone');

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
