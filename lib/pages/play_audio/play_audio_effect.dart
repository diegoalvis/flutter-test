import 'package:bogota_app/view_model.dart';

abstract class PlayAudioEffect extends Effect {

}

class PlayAudioValueControllerScrollEffect extends PlayAudioEffect {
  final int duration;
  final bool next;

  PlayAudioValueControllerScrollEffect(this.duration, this.next);
}

class ShowDialogEffect extends PlayAudioEffect {
  ShowDialogEffect();
}
