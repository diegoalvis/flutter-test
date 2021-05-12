import 'dart:convert';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/response_gps_model.dart';
import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class GpsService {

  Future<IdtResult<GpsModel?>> setLocationUser(GpsModel gpsModel) async {

    final uri = Uri.https(IdtConstants.url_server, '/guardar_coordenadas');

/*
    var map = {
      'imei' : gpsModel.imei,
      'latitud' : gpsModel.latitud,
      'longitud' : gpsModel.longitud,
      'fecha' : gpsModel.fecha,
      "nombre": "Test",
      "apellido": "Apellido Test",
      "motivo_viaje": "MOtivo del viaje",
      "pais": "Colombia",
      "ciudad": "Bogota"
    };
*/

    final response = await http.post(uri, body: gpsModel.toJson());

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200: {
          final entity = ResponseGpsModel.fromJson(body);

          return IdtResult.success(entity.data);
        }

        default: {
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