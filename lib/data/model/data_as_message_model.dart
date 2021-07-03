
import 'package:json_annotation/json_annotation.dart';

part 'data_as_message_model.g.dart';

@JsonSerializable()
class DataAsMessageModel {

  final String? message;

  DataAsMessageModel(this.message);

  factory DataAsMessageModel.fromJson(Map<String, dynamic> json) => _$DataAsMessageModelFromJson(json);


  Map<String, dynamic> toJson() => _$DataAsMessageModelToJson(this);
}