import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_user_model.g.dart';
//ResponseDetailModel = DataPlacesDetailModel
@JsonSerializable()
class ResponseUserModel extends IdtModel {

  final int? status;
  final UserModel? data;

  ResponseUserModel({this.status, this.data});

  factory ResponseUserModel.fromJson(Map<String, dynamic> json) => _$ResponseUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserModelToJson(this);
}