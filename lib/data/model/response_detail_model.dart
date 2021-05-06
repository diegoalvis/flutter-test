import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_detail_model.g.dart';
@JsonSerializable()
class ResponseDetailModel extends IdtModel {

  final int? status;
  final DataPlacesDetailModel? data;

  ResponseDetailModel({this.status, this.data});

  factory ResponseDetailModel.fromJson(Map<String, dynamic> json) => _$ResponseDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDetailModelToJson(this);
}