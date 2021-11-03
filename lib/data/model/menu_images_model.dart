import 'package:json_annotation/json_annotation.dart';

import 'idt_model.dart';

part 'menu_images_model.g.dart';

@JsonSerializable()
class MenuImagesModel extends IdtModel {
  final String title;
  final List images_menu;
  final List text_menu;

  final String appword18;
  final String appword60;
  final String appword61;
  final String appword4;
  final String appword62;
  final String appword52;
  final String appword19;
  final String appword55;
  final String appword58;
  final String appword53;
  final String appword10;
  final String appword21;
  final String appword45;
  final String appword56;
  final String appword54;
  final String appword1;
  final String appword7;
  final String appword38;
  final String appword33;
  final String appword34;
  final String appword49;
  final String appword50;
  final String appword47;
  final String appword48;
  final String appword36;
  final String appword37;
  final String appword51;
  final String appword8;
  final String appword32;
  final String appword63;
  final String appword46;
  final String appword11;
  final String appword59;
  final String appword9;
  final String appword20;
  final String appword6;
  final String appword12;
  final String appword3;
  final String appword5;
  final String appword23;
  final String appword26;
  final String appword27;
  final String appword24;
  final String appword22;
  final String appword25;
  final String appword2;
  final String appword28;
  final String appword14;
  final String appword13;
  final String appword30;
  final String appword16;
  final String appword15;
  final String appword29;
  final String appword17;
  final String appword31;
  final String appword42;
  final String appword43;
  final String appword41;
  final String appword40;
  final String appword44;
  final String appword39;
  final String appword35;
  final String appword57;

  MenuImagesModel(
    this.title,
    this.images_menu,
    this.text_menu,
    this.appword18,
    this.appword60,
    this.appword61,
    this.appword4,
    this.appword62,
    this.appword52,
    this.appword19,
    this.appword55,
    this.appword58,
    this.appword53,
    this.appword10,
    this.appword21,
    this.appword45,
    this.appword56,
    this.appword54,
    this.appword1,
    this.appword7,
    this.appword38,
    this.appword33,
    this.appword34,
    this.appword49,
    this.appword50,
    this.appword47,
    this.appword48,
    this.appword36,
    this.appword37,
    this.appword51,
    this.appword8,
    this.appword32,
    this.appword63,
    this.appword46,
    this.appword11,
    this.appword59,
    this.appword9,
    this.appword20,
    this.appword6,
    this.appword12,
    this.appword3,
    this.appword5,
    this.appword23,
    this.appword26,
    this.appword27,
    this.appword24,
    this.appword22,
    this.appword25,
    this.appword2,
    this.appword28,
    this.appword14,
    this.appword13,
    this.appword30,
    this.appword16,
    this.appword15,
    this.appword29,
    this.appword17,
    this.appword31,
    this.appword42,
    this.appword43,
    this.appword41,
    this.appword40,
    this.appword44,
    this.appword39,
    this.appword35,
    this.appword57,
  );

  factory MenuImagesModel.fromJson(Map<String, dynamic> json) =>
      _$MenuImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuImagesModelToJson(this);
}
