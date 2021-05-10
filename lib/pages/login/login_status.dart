import 'package:bogota_app/view_model.dart';

class LoginStatus extends ViewStatus{

  final bool isLoading;
  final String email;
  final String password;
  late String? message;

  LoginStatus({required this.isLoading,required this.email,required this.password, this.message });

  LoginStatus copyWith({bool? isLoading, String? username, String? password, String? message}) {
    return LoginStatus(
        isLoading: isLoading ?? this.isLoading,
      email: username ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,

    );
  }
}
