import 'package:json_annotation/json_annotation.dart';

part 'user_data_request.g.dart';

@JsonSerializable()
//UserModel
class UserDataRequest {
//enviar
  final String? name;
  final String? email;
  @JsonKey(name: 'last_name')
  final String? lastName;

  // final String? country;
  // final String? city;
  // @JsonKey(name: 'reason_trip')
  // final String? reasonTrip;

  UserDataRequest({
    this.email,
    this.name,
    this.lastName,
    // this.country, this.reasonTrip ,this.city,
  });

  factory UserDataRequest.fromJson(Map<String, dynamic> json) =>
      _$UserDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataRequestToJson(this);
}
