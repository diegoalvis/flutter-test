import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
//UserRequest??
class RegisterRequest {

  late  String? name;
  late  String? last_name;
  late  String? country;
  late String? reason_trip;
  late String? mail;
  late String? city;
  late String? password;


  RegisterRequest(this.name, this.last_name, this.country, this.reason_trip, this.mail, this.city,
      this.password);

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);


  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

}