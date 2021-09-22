import 'package:bogota_app/data/model/idt_model.dart';


import 'package:json_annotation/json_annotation.dart';

part 'language_model.g.dart';
@JsonSerializable()
class LanguageModel extends IdtModel {

  late final String? name;
  late final String? prefix;


  LanguageModel({this.name, this.prefix});


  factory LanguageModel.fromJson(Map<String, dynamic> json) => _$LanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);

  LanguageModel.fromJsonManual(Map<String, dynamic> json) {
    name = json['name'];
    prefix = json['prefix'];
  }

  Map<String, dynamic> toJsonManual() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['prefix'] = this.prefix;
    return data;
  }
}