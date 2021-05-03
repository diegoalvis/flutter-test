import 'package:bogota_app/view_model.dart';

class RegisterUserStatus extends ViewStatus {
  final bool isLoading;
  final bool isAlert;

  RegisterUserStatus({
    required this.isLoading,
    required this.isAlert,
  });

  RegisterUserStatus copyWith({
    bool? isLoading, bool? isAlert,
  }) {
    return RegisterUserStatus(
      isLoading: isLoading ?? this.isLoading,
      isAlert: isAlert ?? this.isAlert
    );
  }
}
