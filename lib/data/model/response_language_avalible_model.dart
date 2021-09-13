import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/language_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_language_avalible_model.g.dart';
@JsonSerializable()
class ResponseLanguageAvalibleModel extends IdtModel {

  final int? status;
  final List<LanguageModel>? data;

  ResponseLanguageAvalibleModel({this.status, this.data});

  factory ResponseLanguageAvalibleModel.fromJson(Map<String, dynamic> json) => _$ResponseLanguageAvalibleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLanguageAvalibleModelToJson(this);
}