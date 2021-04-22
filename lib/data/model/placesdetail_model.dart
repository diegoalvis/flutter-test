import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'placesdetail_model.g.dart';

@JsonSerializable()
class DataPlacesDetailModel extends IdtModel {

  final String? id;
  final String? title;
  final String? body;
  final String? image;
  final String? audioguia_es;
  final String? audioguia_en;
  final String? audioguia_pt;
  final String? rate;
  final String? location;
  final String? address;
  final List? gallery;
  final List? ids_subcategories;


  //@JsonKey(name: 'audioguia_es')
  //final String? urlAudioguia;

  DataPlacesDetailModel({this.id, this.title,this.body, this.image,this.audioguia_es,this.audioguia_en,this.audioguia_pt, this.rate, this.location,
    this.address, this.gallery, this.ids_subcategories});

  factory DataPlacesDetailModel.fromJson(Map<String, dynamic> json) => _$DataPlacesDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataPlacesDetailModelToJson(this);
}