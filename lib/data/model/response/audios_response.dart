import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../audios_model.dart';

part 'audios_response.g.dart';
@JsonSerializable()
class AudiosResponseModel extends IdtModel {

  final int? status;
  final AudiosModel? data;

  AudiosResponseModel({this.status, this.data});

  factory AudiosResponseModel.fromJson(Map<String, dynamic> json) => _$AudiosResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AudiosResponseModelToJson(this);
}