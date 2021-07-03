import 'package:bogota_app/data/model/data_as_message_model.dart';
import 'package:bogota_app/data/model/idt_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_user_response.g.dart';

@JsonSerializable()
class DeleteUserResponse extends IdtModel {
  final int? status;
  final DataAsMessageModel? data;

  DeleteUserResponse({this.status, this.data});

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteUserResponseToJson(this);
}
