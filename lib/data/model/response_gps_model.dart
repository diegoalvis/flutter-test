import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_gps_model.g.dart';

@JsonSerializable()
class ResponseGpsModel extends IdtModel {

  final int? status;
  final GpsModel? data;

  ResponseGpsModel({this.status, this.data});

  factory ResponseGpsModel.fromJson(Map<String, dynamic> json) => _$ResponseGpsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGpsModelToJson(this);
}