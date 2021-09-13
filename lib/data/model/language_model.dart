import 'package:bogota_app/data/model/idt_model.dart';


import 'package:json_annotation/json_annotation.dart';

part 'language_model.g.dart';
@JsonSerializable()
class LanguageModel extends IdtModel {

  final String? name;
  final String? prefix;


  LanguageModel({this.name, this.prefix});


  factory LanguageModel.fromJson(Map<String, dynamic> json) => _$LanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);

}