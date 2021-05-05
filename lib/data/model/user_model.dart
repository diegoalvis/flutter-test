import 'package:bogota_app/data/model/idt_model.dart';


import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends IdtModel {

  final String? id;
  final String? name;
  final String? mail;
  final String? country;
  final String? password;

  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'reason_trip')
  final String? reasonTrip;

  UserModel({required this.id,this.mail, this.password, this.name, this.country, this.lastName, this.reasonTrip});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);


  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}