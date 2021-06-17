import 'dart:convert';

import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/response_model.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class FilterService {
  //Este metodo trae los lugares apenas se entra al filter Page
  Future<IdtResult<List<DataModel>?>> getPlaces(Map params) async {
    Map<String, dynamic> queryParameters = {};

    await getAllParams(params, queryParameters);
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

  Future<void> getAllParams(Map<dynamic, dynamic> params, Map<String, dynamic> queryParameters) async {
    List<Stream> listSubcategory = [];
    List<String> listIdsSubcategory = [];
    
    // Se obtienen las listas para manejo más fácil en ciclo for
    final keys = params.keys.toList();
    final values = params.values.toList();

    for (var i = 0; i < params.keys.length; i++) {

      // En caso de ser subcategoria, se consulta con el api de subcategoria para recuperar sus ID
      if (keys[i] == 'subcategory') {
        List<String> ids = (values[i] as String).split(",");


        ids.forEach((id) {
          // Se prepara una lista de peticiones
          listSubcategory.add(
            locator<ApiInteractor>().getPlacesSubcategory(id).asStream(),
          );
        });

        // Se ejecutan en bloque la lista de peticiones de subcategorias
        await Rx.forkJoinList(listSubcategory)
            .listen((event) async {

              // Se recibe un array de respuestas de cada petición
              event.forEach((element) {

                // Se analiza cada respuesta
                if (element is IdtSuccess<List<DataModel>?>) {

                  // Cada subcategoria arroja una serie de ids, estos se recuperan en una lista.
                  List<DataModel> dato = element.body as List<DataModel>;
                  dato.forEach((element) {
                    listIdsSubcategory.add(element.id);
                  });
                } else {
                  print('❌ Error en consulta de una subcategoria');
                }
              });
            })
            .asFuture()
            .then((value) {

              if (listIdsSubcategory.length > 0) {
                // Finalmente, para la la agrupación de subcategory, la lista de ids se une separado por comas,
                queryParameters[keys[i]] = listIdsSubcategory.join(",");
              }
            });
      } else {
        queryParameters[keys[i]] = values[i];
      }
    }
  }


  Future<IdtResult<List<DataModel>?>> getPlaceSubcategories(String id) async {
    
    final uri = Uri.https(IdtConstants.url_server, '/subcategory/' +id,);

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);
      print(body);
      switch (response.statusCode) {
        case 200: {
            final entity = ResponseModel.fromJson(body);
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

  Future<IdtResult<List<DataModel>?>> getPlaceEventForLocation(Map params, String section) async {
    Map<String, dynamic> queryParameters = {};

    params.forEach((key, value) {
      queryParameters[key] = value;
      /*value.keys.forEach((element) {
        queryParameters[element] = value[element];
      });*/
      // queryParameters[value.keys.first] = value.values.first;
    });

    final uri = Uri.https(IdtConstants.url_server, '/$section', queryParameters);

    print(uri.toString());
    final response = await http.get(uri);
    print('**response: ${response.body}');
    try {
      final body = json.decode(response.body);
      print(body);
      switch (response.statusCode) {
        case 200: {
          final entity = ResponseModel.fromJson(body);
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
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/category');

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

  Future<IdtResult<List<DataModel>?>> getSubcategories() async {
    final queryParameters = {'zone': '23'};

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/subcategory');

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
