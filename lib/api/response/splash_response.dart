import 'package:bogota_app/api/model/data_places_model.dart';
import 'package:bogota_app/api/model/idt_model.dart';
import 'package:bogota_app/api/model/splash_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'splash_response.g.dart';

@JsonSerializable()
class SplashResponse extends IdtModel {

  final int? status;
  final SplashModel data;

  SplashResponse({this.status,required this.data});

  factory SplashResponse.fromJson(Map<String, dynamic> json) => _$SplashResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SplashResponseToJson(this);
}

