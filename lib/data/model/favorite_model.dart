import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/response/register_response.dart';


import 'package:json_annotation/json_annotation.dart';

part 'favorite_model.g.dart';

@JsonSerializable()
class FavoriteModel {

  final String? message;

  FavoriteModel(this.message);

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => _$FavoriteModelFromJson(json);


  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);
}