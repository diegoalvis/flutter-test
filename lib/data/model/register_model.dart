import 'package:bogota_app/data/model/idt_model.dart';


import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel  {

  final int? id;
  final String? name;
  final String? country;
  final String? apellido;
  final String? reason_trip;
  final String? message;

  RegisterModel(this.id, this.name, this.country, this.apellido, this.reason_trip,this.message);

  factory RegisterModel.fromJson(Map<String, dynamic> json) => _$RegisterModelFromJson(json);


  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}