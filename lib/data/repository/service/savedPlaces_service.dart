import 'dart:convert';
import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/response/audioguides_response.dart';

import 'package:bogota_app/data/model/response/places_response.dart';

import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:http/http.dart' as http;

class SavedPlacesService {
  Future<IdtResult<List<DataAudioGuideModel>?>> getSavedPlaces() async {
    CurrentUser user = BoxDataSesion.getCurrentUser()!;
    final Person? person = await BoxDataSesion.getFromBox(user.id_db!);

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(
        IdtConstants.url_server, '/user/${person?.id.toString()}/places');

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          {
            final entity = AudioGuidesResponse.fromJson(body);
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
