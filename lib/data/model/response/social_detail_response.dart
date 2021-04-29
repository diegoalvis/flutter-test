import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/placesdetail_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../audioguide_model.dart';
part 'social_detail_response.g.dart';

@JsonSerializable()
class SocialDetailResponse extends IdtModel {

  final int? status;
  final DataPlacesDetailModel? data;

  SocialDetailResponse({this.status, this.data});

  factory SocialDetailResponse.fromJson(Map<String, dynamic> json) => _$SocialDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SocialDetailResponseToJson(this);
}