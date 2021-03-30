import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataModel extends IdtModel {

  final String id;
  final String? title;
  final String? image;
  final String? video;

  @JsonKey(name: 'id_subcategory')
  final String?  idSubcategiry;

  @JsonKey(name: 'url_audioguia')
  final String? urlAudioguia;

  @JsonKey(name: 'cover_image')
  final String? coverImage;

  DataModel({ required this.id, this.title, this.image, this.video, this.urlAudioguia,
    this.idSubcategiry, this.coverImage
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}