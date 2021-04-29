import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'places_social_detail_model.g.dart';

@JsonSerializable()
class DataPlacesSocialDetailModel extends IdtModel {

  final String id;
  final String? title;
  final String? date;
  final String? description;
  final String? location;
  final String? video;
  final String? phone;
  final String? place;
  final List? gallery;


  @JsonKey(name: 'cover_image')
  final String? coverImage;

  @JsonKey(name: 'seo_image')
  final String? seoImage;

  //@JsonKey(name: 'audioguia_es')
  //final String? urlAudioguia;

  DataPlacesSocialDetailModel({required this.id, this.title, this.date, this.description, this.location, this.video, this.phone, this.place, this.gallery, this.coverImage, this.seoImage, });

  factory DataPlacesSocialDetailModel.fromJson(Map<String, dynamic> json) => _$DataPlacesSocialDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataPlacesSocialDetailModelToJson(this);
}