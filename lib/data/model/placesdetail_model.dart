import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'placesdetail_model.g.dart';

@JsonSerializable()
class DataPlacesDetailModel extends IdtModel {

  final String id;
  final String? title;
  final String? body;
  final String? description;
  final String? date;
  final String? image;
  final String? video;
  final String? phone;
  final String? place;
  final String? audioguia_es;
  final String? audioguia_en;
  final String? audioguia_pt;
  final String? rate;
  final String? location;
  final String? address;
  final List? gallery;
  final List? ids_subcategories;

  @JsonKey(name: 'web_url')
  final String? webUrl;

  @JsonKey(name: 'cover_image')
  final String? coverImage;

  @JsonKey(name: 'seo_image')
  final String? seoImage;

  //@JsonKey(name: 'audioguia_es')
  //final String? urlAudioguia;

  DataPlacesDetailModel( {required this.id,this.description,this.coverImage, this.seoImage, this.webUrl, this.date, this.video, this.phone, this.place,  this.title,this.body, this.image,this.audioguia_es,this.audioguia_en,this.audioguia_pt, this.rate, this.location,
    this.address, this.gallery, this.ids_subcategories});

  factory DataPlacesDetailModel.fromJson(Map<String, dynamic> json) => _$DataPlacesDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataPlacesDetailModelToJson(this);
}