import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'audioguide_model.g.dart';

@JsonSerializable()
class DataAudioGuideModel extends IdtModel {
  final String? id;
  final String? title;
  final String? main_img;
  final String? image;
  final String? audioguia_es;
  final String? audioguia_en;
  final String? audioguia_pt;
  final List<String>? audios;
  late bool? isFavorite;
  late bool? isLocal;

  //@JsonKey(name: 'audioguia_es')
  //final String? urlAudioguia;

  DataAudioGuideModel({
    this.id,
    this.title,
    this.main_img,
    this.image,
    this.audioguia_es,
    this.audioguia_en,
    this.audioguia_pt,
    this.isFavorite,
    this.isLocal,
    this.audios,
  });

  factory DataAudioGuideModel.fromJson(Map<String, dynamic> json) =>
      _$DataAudioGuideModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataAudioGuideModelToJson(this);
}
