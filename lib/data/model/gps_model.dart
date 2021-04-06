import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'gps_model.g.dart';

@JsonSerializable()
class GpsModel extends IdtModel {

  final String imei;
  final String? latitud;
  final String? longitud;
  final String? fecha;

  GpsModel({ required this.imei, this.latitud, this.longitud, this.fecha });

  factory GpsModel.fromJson(Map<String, dynamic> json) => _$GpsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GpsModelToJson(this);
}