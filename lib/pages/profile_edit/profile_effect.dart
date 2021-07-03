import 'package:bogota_app/view_model.dart';

abstract class ProfileEditEffect extends Effect {

}

class ProfileEditValueControllerScrollEffect extends ProfileEditEffect {
  final bool state;

  ProfileEditValueControllerScrollEffect(this.state);
}

class ShowProfileEditDialogEffect extends ProfileEditEffect {
  String? message;
  ShowProfileEditDialogEffect(message);
}