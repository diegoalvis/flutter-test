import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel extends IdtModel {

  final int? status;
  final List<DataModel>? data;

  ResponseModel({this.status, this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}