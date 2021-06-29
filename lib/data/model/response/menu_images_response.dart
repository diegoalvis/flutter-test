
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/menu_images_model.dart';


import 'package:bogota_app/data/model/splash_model.dart';


import 'package:json_annotation/json_annotation.dart';

part 'menu_images_response.g.dart';

@JsonSerializable()
class MenuImagesResponse extends IdtModel {

  final int? status;
  final MenuImagesModel data;

  MenuImagesResponse({this.status,required this.data});

  factory MenuImagesResponse.fromJson(Map<String, dynamic> json) => _$MenuImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MenuImagesResponseToJson(this);
}

