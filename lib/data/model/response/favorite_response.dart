import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/favorite_model.dart';
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'favorite_response.g.dart';

@JsonSerializable()
class FavoriteResponse extends IdtModel {

  final int? status;
  final FavoriteModel? data;

  FavoriteResponse({this.status, this.data});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) => _$FavoriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteResponseToJson(this);
}