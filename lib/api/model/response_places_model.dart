import 'package:bogota_app/api/model/data_places_model.dart';
import 'package:bogota_app/api/model/idt_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_places_model.g.dart';

@JsonSerializable()
class ResponsePlacesModel extends IdtModel {

  final int? status;
  final List<DataPlacesModel>? data;

  ResponsePlacesModel({this.status, this.data});

  factory ResponsePlacesModel.fromJson(Map<String, dynamic> json) => _$ResponsePlacesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePlacesModelToJson(this);
}