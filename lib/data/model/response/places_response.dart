import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'places_response.g.dart';

@JsonSerializable()
class PlacesResponse extends IdtModel {

  final int? status;
  final List<DataPlacesModel>? data;

  PlacesResponse({this.status, this.data});

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => _$PlacesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesResponseToJson(this);
}