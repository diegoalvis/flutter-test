import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/places_social_detail_model.dart';
import 'package:bogota_app/data/model/placesdetail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_socialdetail_model.g.dart';

@JsonSerializable()
class ResponseSocialDetailModel extends IdtModel {

  final int? status;
  final DataPlacesSocialDetailModel? data;

  ResponseSocialDetailModel({this.status, this.data});

  factory ResponseSocialDetailModel.fromJson(Map<String, dynamic> json) => _$ResponseSocialDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSocialDetailModelToJson(this);
}