import 'package:bogota_app/view_model.dart';

abstract class RegisterEffect extends Effect {

}

class RegisterValueControllerScrollEffect extends RegisterEffect {
  final bool state;

  RegisterValueControllerScrollEffect(this.state);
}

class ShowRegisterDialogEffect extends RegisterEffect {
  String? message;
  ShowRegisterDialogEffect(message);
}