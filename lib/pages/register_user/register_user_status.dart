import 'package:bogota_app/view_model.dart';

class RegisterUserStatus extends ViewStatus {
  final bool isLoading;

  RegisterUserStatus({
    required this.isLoading,
  });

  RegisterUserStatus copyWith({
    bool? isLoading,
  }) {
    return RegisterUserStatus(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
