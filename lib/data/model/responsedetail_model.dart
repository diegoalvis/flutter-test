import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/placesdetail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'responsedetail_model.g.dart';

@JsonSerializable()
class ResponseDetailModel extends IdtModel {

  final int? status;
  final DataPlacesDetailModel? data;

  ResponseDetailModel({this.status, this.data});

  factory ResponseDetailModel.fromJson(Map<String, dynamic> json) => _$ResponseDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDetailModelToJson(this);
}