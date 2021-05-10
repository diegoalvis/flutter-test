import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
//UserRequest??
class RegisterRequest {

  late  String? username;
  late  String? name;
  late  String? mail;
  late String? country;
  late String? last_name;
  late String? reason_trip;
  late String? password;

  RegisterRequest(this.username,this.name, this.mail, this.country, this.last_name, this.reason_trip, this.password);

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);


  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}