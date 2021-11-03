
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/words_and_menu_images_model.dart';

import 'package:bogota_app/data/model/words_and_menu_images_model.dart';


import 'package:json_annotation/json_annotation.dart';

part 'words_and_menu_images_response.g.dart';

@JsonSerializable()
class WordsAndMenuImagesResponse extends IdtModel {

  final int? status;
  final WordsAndMenuImagesModel data;

  WordsAndMenuImagesResponse({this.status,required this.data});

  factory WordsAndMenuImagesResponse.fromJson(Map<String, dynamic> json) => _$WordsAndMenuImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WordsAndMenuImagesResponseToJson(this);
}

