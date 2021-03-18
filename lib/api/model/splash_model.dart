import 'package:bogota_app/api/model/idt_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'splash_model.g.dart';

@JsonSerializable()
class SplashModel extends IdtModel {

  final String? title;
  final String? background;
  final String? logo;

  SplashModel(this.title, this.background, this.logo);

  factory SplashModel.fromJson(Map<String, dynamic> json) => _$SplashModelFromJson(json);


  Map<String, dynamic> toJson() => _$SplashModelToJson(this);
}