import 'package:bogota_app/view_model.dart';

abstract class LoginEffect extends Effect {

}

class LoginValueControllerScrollEffect extends LoginEffect {
  final bool state;

  LoginValueControllerScrollEffect(this.state);
}

class ShowLoginDialogEffect extends LoginEffect {
  String? message;
  ShowLoginDialogEffect(message);
}