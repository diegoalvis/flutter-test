import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'audioguide_model.g.dart';

@JsonSerializable()
class DataAudioGuideModel extends IdtModel {

  final String? id;
  final String? title;
  final String? image;

  @JsonKey(name: 'url_audioguia')
  final String? urlAudioguia;

  DataAudioGuideModel({this.id, this.title, this.image, this.urlAudioguia, String? audioguia_es, String? audioguia_en, String? audioguia_pt});

  factory DataAudioGuideModel.fromJson(Map<String, dynamic> json) => _$DataAudioGuideModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataAudioGuideModelToJson(this);
}