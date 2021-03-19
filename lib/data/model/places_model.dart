import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'places_model.g.dart';

@JsonSerializable()
class DataPlacesModel extends IdtModel {

  final String? id;
  final String? title;
  final String? image;

  @JsonKey(name: 'url_audioguia')
  final String? urlAudioguia;

  DataPlacesModel({this.id, this.title, this.image, this.urlAudioguia});

  factory DataPlacesModel.fromJson(Map<String, dynamic> json) => _$DataPlacesModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataPlacesModelToJson(this);
}