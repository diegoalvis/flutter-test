import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'audios_model.g.dart';

@JsonSerializable()
class AudiosModel extends IdtModel {
  final String? id;
  final String? title;
  final String? main_img;
  final String? image;
  late bool? isLocal;
  final List? audios;

  //@JsonKey(name: 'audioguia_es')
  //final String? urlAudioguia;

  AudiosModel({
    this.id,
    this.title,
    this.main_img,
    this.image,
    this.isLocal,
    this.audios
  });

  factory AudiosModel.fromJson(Map<String, dynamic> json) =>
      _$AudiosModelFromJson(json);

  Map<String, dynamic> toJson() => _$AudiosModelToJson(this);
}
