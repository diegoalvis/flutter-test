import 'package:bogota_app/data/model/request/register_request.dart';
import 'package:bogota_app/view_model.dart';

class RegisterUserStatus extends ViewStatus {
  final bool isLoading;
  late String? message;
  RegisterRequest? data;

  RegisterUserStatus({
    required this.isLoading,
    this.message,
    required this.data
  });

  RegisterUserStatus copyWith({
    bool? isLoading, String? message, RegisterRequest? data
  }) {
    return RegisterUserStatus(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      data: data ?? this.data
    );
  }
}
