import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'gps_model.g.dart';

@JsonSerializable()
class GpsModel extends IdtModel {

  late String? imei;
  late String? latitud;
  late String? longitud;
  late String? fecha;
  late String? nombre;
  late String? apellido;
  late String? motivo_viaje;
  late String? pais;
  late String? ciudad;

  GpsModel({ this.imei, this.latitud, this.longitud, this.fecha, this.nombre, this.apellido, this.motivo_viaje, this.pais, this.ciudad });

  factory GpsModel.fromJson(Map<String, dynamic> json) => _$GpsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GpsModelToJson(this);
}