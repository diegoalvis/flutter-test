
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/request/user_data_request.dart';


import 'package:bogota_app/data/model/splash_model.dart';
import 'package:bogota_app/data/model/user_model.dart';


import 'package:json_annotation/json_annotation.dart';

part 'user_update_response.g.dart';

@JsonSerializable()
class UserUpdateResponse extends IdtModel {
//recibir
  final int? status;
  final UserDataRequest? data;
  // final UserModel? data;



  UserUpdateResponse({this.status,required this.data});

  factory UserUpdateResponse.fromJson(Map<String, dynamic> json) => _$UserUpdateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateResponseToJson(this);
}

