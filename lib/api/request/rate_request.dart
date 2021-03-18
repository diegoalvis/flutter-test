import 'package:json_annotation/json_annotation.dart';

part 'rate_request.g.dart';

@JsonSerializable()
class RateRequest {

  final String? hotel;
  final String? rate;

  RateRequest(this.hotel, this.rate ,);

  factory RateRequest.fromJson(Map<String, dynamic> json) => _$RateRequestFromJson(json);


  Map<String, dynamic> toJson() => _$RateRequestToJson(this);
}