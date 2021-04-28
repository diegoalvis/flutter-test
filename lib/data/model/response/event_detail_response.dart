import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/places_social_detail_model.dart';
import 'package:bogota_app/data/model/placesdetail_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../audioguide_model.dart';
part 'event_detail_response.g.dart';

@JsonSerializable()
class EventDetailResponse extends IdtModel {

  final int? status;
  final DataPlacesSocialDetailModel? data;

  EventDetailResponse({this.status, this.data});

  factory EventDetailResponse.fromJson(Map<String, dynamic> json) => _$EventDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailResponseToJson(this);
}