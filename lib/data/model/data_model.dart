import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataModel extends IdtModel {
  final String id;
  final String? date;
  final String? title;
  final String? image;
  final String? video;
  final String? type;
  bool? isFavorite;

  @JsonKey(name: 'id_subcategory')
  final String? idSubcategiry;

  @JsonKey(name: 'url_audioguia')
  final String? urlAudioguia;

  @JsonKey(name: 'cover_image')
  final String? coverImage;

  @JsonKey(name: 'seo_image')
  final String? seoImage;

  DataModel({
    required this.type,
    required this.id,
    this.date,
    this.seoImage,
    this.title,
    this.image,
    this.video,
    this.urlAudioguia,
    this.idSubcategiry,
    this.coverImage,
    this.isFavorite,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
