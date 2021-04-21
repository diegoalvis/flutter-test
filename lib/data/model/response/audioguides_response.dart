import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../audioguide_model.dart';
part 'audioguides_response.g.dart';

@JsonSerializable()
class AudioGuidesResponse extends IdtModel {

  final int? status;
  final List<DataAudioGuideModel>? data;

  AudioGuidesResponse({this.status, this.data});

  factory AudioGuidesResponse.fromJson(Map<String, dynamic> json) => _$AudioGuidesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AudioGuidesResponseToJson(this);
}