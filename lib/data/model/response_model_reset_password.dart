import 'package:bogota_app/data/model/idt_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_model_reset_password.g.dart';

@JsonSerializable()
class ResponseResetPasswordModel extends IdtModel {
  final int? status;
  final Map<String, dynamic>? data;

  ResponseResetPasswordModel({this.status, this.data});

  factory ResponseResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseResetPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseResetPasswordModelToJson(this);
}
