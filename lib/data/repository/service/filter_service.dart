import 'dart:convert';

import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/response_model.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';

import 'package:http/http.dart' as http;


class FilterService {

  Future<IdtResult<List<DataModel>?>> getPlaces(Map params) async {

    Map<String, dynamic> queryParameters = {};

    params.forEach((key, value) {

      queryParameters[key] = value;
      /*value.keys.forEach((element) {
        queryParameters[element] = value[element];
      });*/
      // queryParameters[value.keys.first] = value.values.first;
    });

    print('Parametro: $queryParameters');
    final uri = Uri.https(IdtConstants.url_server, '/place', queryParameters);

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200: {
          final entity = ResponseModel.fromJson(body);

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

  Future<IdtResult<DataPlacesDetailModel?>> getPlaceById(String id) async {

    final uri = Uri.https(IdtConstants.url_server, '/place/' +id,);

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);
      print(body);
      switch (response.statusCode) {
        case 200: {
          final entity = ResponseDetailModel.fromJson(body);
          print(entity.data);
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
  Future<IdtResult<List<DataModel>?>> getCategories() async {

    final queryParameters = {
      'zone': '23'
    };

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/category');

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200: {
          final entity = ResponseModel.fromJson(body);

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

  Future<IdtResult<List<DataModel>?>> getSubcategories() async {

    final queryParameters = {
      'zone': '23'
    };

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/subcategory');

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200: {
          final entity = ResponseModel.fromJson(body);

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

  Future<IdtResult<List<DataModel>?>> getZones() async {

    final queryParameters = {
      'zone': '23'
    };

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/zone');

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200: {
          final entity = ResponseModel.fromJson(body);

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

  /*Future<IdtResult<List<DataPlacesModel>?>> getPlaces() async {

    final queryParameters = {
      'zone': '23'
    };

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/event');

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200: {
          final entity = PlacesResponse.fromJson(body);

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

  }*/
}