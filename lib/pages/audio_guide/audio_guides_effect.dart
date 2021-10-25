import 'package:bogota_app/view_model.dart';

abstract class AudioGuidesEffect extends Effect {

}

class AudioGuidesValueControllerScrollEffect extends AudioGuidesEffect {
  final int duration;
  final bool next;

  AudioGuidesValueControllerScrollEffect(this.duration, this.next);
}

class ShowDialogEffect extends AudioGuidesEffect {

  //pasar too lo necesario
  ShowDialogEffect();
}
