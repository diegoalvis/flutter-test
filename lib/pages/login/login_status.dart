import 'package:bogota_app/view_model.dart';

class LoginUserStatus extends ViewStatus{

  final bool isLoading;
  final String email;
  final String password;
  late String? message;

  LoginUserStatus({required this.isLoading,required this.email,required this.password, this.message });

  LoginUserStatus copyWith({bool? isLoading, String? username, String? password, String? message}) {
    return LoginUserStatus(
        isLoading: isLoading ?? this.isLoading,
      email: username ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,

    );
  }
}
