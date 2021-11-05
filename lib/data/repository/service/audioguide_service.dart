import 'dart:convert';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/response/audioguides_response.dart';
import 'package:bogota_app/data/model/response_model.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/errors/zones_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;

class AudioGuideService {
  Future<IdtResult<List<DataAudioGuideModel>?>> getAudioGuidesForLocation(Map<String,String>
      params, String lanUser) async {
    params["lan"] = lanUser;

    final uri = Uri.https(IdtConstants.url_server, '/audio', params);

    final response = await http.get(uri);
    print('**response: ${response.body}');
    try {
      final body = json.decode(response.body);
      print(body);
      switch (response.statusCode) {
        case 200:
          {
            final entity = AudioGuidesResponse.fromJson(body);
            print(entity.data);
            return IdtResult.success(entity.data);
          }

        default:
          {
            final error = ZonesError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = ZonesError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }

  Future<IdtResult<List<DataAudioGuideModel>?>> getAudioGuide(
      String lanUser) async {
    var queryParameters = {
      'lan': lanUser,
    };
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/audio/', queryParameters);

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
