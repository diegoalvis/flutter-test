import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse extends IdtModel {

  final int? status;
  final RegisterModel? data;

  RegisterResponse({this.status, this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}