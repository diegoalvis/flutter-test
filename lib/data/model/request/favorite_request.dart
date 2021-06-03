import 'package:json_annotation/json_annotation.dart';

part 'favorite_request.g.dart';

@JsonSerializable()
//UserRequest??
class FavoriteRequest {

  late  String? user;
  late  String? place;

  FavoriteRequest(this.user, this.place ,);

  factory FavoriteRequest.fromJson(Map<String, dynamic> json) => _$FavoriteRequestFromJson(json);


  Map<String, dynamic> toJson() => _$FavoriteRequestToJson(this);
}