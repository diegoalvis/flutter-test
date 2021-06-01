import 'dart:convert';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';
import 'package:bogota_app/data/model/response_model.dart';

import 'package:bogota_app/utils/errors/search_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;

class SearchService {

  Future<IdtResult<List<DataModel>?>> getResultByWord(Map params) async {

    Map<String, dynamic> queryParameters = {};

    params.forEach((key, value) {

      queryParameters[key] = value;
      /*value.keys.forEach((element) {
        queryParameters[element] = value[element];
      });*/
      // queryParameters[value.keys.first] = value.values.first;
    });
    print('Parametro: $queryParameters');

    final uri = Uri.https(IdtConstants.url_server, '/util/search' ,queryParameters,);
    print(uri);
    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);
      print(body);
      switch (response.statusCode) {
        case 200: {
          final entity = ResponseModel.fromJson(body);
          return IdtResult.success(entity.data);
        }

        default: {
          final error = SearchError('Capturar el error', response.statusCode);

          return IdtResult.failure(error);
        }
      }

    } on StateError catch (err) {
      final error = SearchError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }

  }

}
