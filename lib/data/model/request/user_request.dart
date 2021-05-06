import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
//UserModel
class UserRequest {

  final  String? username;
  final  String? password;
  final  String? name;
  final  String? mail;
  final String? country;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'reason_trip')
  final String? reasonTrip;

  UserRequest(this.username, this.password, this.name, this.mail, this.country, this.lastName, this.reasonTrip ,);

  factory UserRequest.fromJson(Map<String, dynamic> json) => _$UserRequestFromJson(json);


  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}