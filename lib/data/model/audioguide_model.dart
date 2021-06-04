import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'audioguide_model.g.dart';

@JsonSerializable()
class DataAudioGuideModel extends IdtModel {
  final String? id;
  final String? title;
  final String? image;
  final String? audioguia_es;
  final String? audioguia_en;
  final String? audioguia_pt;
  late bool? isFavorite;

  //@JsonKey(name: 'audioguia_es')
  //final String? urlAudioguia;

  DataAudioGuideModel({
    this.id,
    this.title,
    this.image,
    this.audioguia_es,
    this.audioguia_en,
    this.audioguia_pt,
    this.isFavorite,
  });

  factory DataAudioGuideModel.fromJson(Map<String, dynamic> json) =>
      _$DataAudioGuideModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataAudioGuideModelToJson(this);
}
