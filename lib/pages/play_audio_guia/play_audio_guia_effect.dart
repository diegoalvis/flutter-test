import 'package:bogota_app/view_model.dart';

abstract class PlayAudioGuiaEffect extends Effect {

}

class PlayAudioGuiaValueControllerScrollEffect extends PlayAudioGuiaEffect {
  final int duration;
  final bool next;

  PlayAudioGuiaValueControllerScrollEffect(this.duration, this.next);
}

class ShowDialogModeOffEffect extends PlayAudioGuiaEffect {
  ShowDialogModeOffEffect();
}

class ShowDialogAddSavedPlaceEffect extends PlayAudioGuiaEffect {
  ShowDialogAddSavedPlaceEffect();
}
