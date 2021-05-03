import 'package:bogota_app/utils/errors/error_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_error.g.dart';


@JsonSerializable()
class RegisterError {

  final int status;
  final ErrorModel  error;

  RegisterError(this.status, this.error);

  factory RegisterError.fromJson(Map<String, dynamic> json) => _$RegisterErrorFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterErrorToJson(this);
}