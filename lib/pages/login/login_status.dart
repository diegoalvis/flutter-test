import 'package:bogota_app/view_model.dart';

class LoginStatus extends ViewStatus{

  final bool isLoading;
  final String username;
  final String password;

  LoginStatus({required this.isLoading,required this.username,required this.password,  });

  LoginStatus copyWith({bool? isLoading, String? username, String? password}) {
    return LoginStatus(
        isLoading: isLoading ?? this.isLoading,
      username: username ?? this.username,
      password: password ?? this.password,

    );
  }
}
