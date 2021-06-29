import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'menu_images_model.g.dart';

@JsonSerializable()
class MenuImagesModel extends IdtModel {

  final List? menu;

  MenuImagesModel({this.menu});

  factory MenuImagesModel.fromJson(Map<String, dynamic> json) =>
      _$MenuImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuImagesModelToJson(this);
}
