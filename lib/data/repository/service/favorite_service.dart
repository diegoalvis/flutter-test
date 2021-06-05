import 'dart:convert';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/favorite_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/request/favorite_request.dart';
import 'package:bogota_app/data/model/response/favorite_response.dart';
import 'package:bogota_app/data/model/response_gps_model.dart';
import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;

class FavoriteService {
  Future<IdtResult<FavoriteModel?>> postFavorite(String idplace) async {
    final Person? person = BoxDataSesion.getFromBox();

    FavoriteRequest fav = FavoriteRequest(person?.id!.toString(), idplace);
    //FavoriteRequest fav = FavoriteRequest("290", idplace);
    print("fav");
    print(fav.toJson());

    final uri = Uri.https(IdtConstants.url_server, '/util/favorite/');

    final response = await http.post(uri, body: fav.toJson());

    try {
      final body = json.decode(response.body);

      print(body);

      switch (response.statusCode) {
        case 200:
          {
            final entity = FavoriteResponse.fromJson(body);

            return IdtResult.success(entity.data);
          }

        default:
          {
            print(response.body);
            final error = GpsError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      print(response.body);
      final error = GpsError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }
}
