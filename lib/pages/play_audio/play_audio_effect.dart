import 'package:bogota_app/view_model.dart';

abstract class PlayAudioEffect extends Effect {

}

class PlayAudioValueControllerScrollEffect extends PlayAudioEffect {
  final int duration;
  final bool next;

  PlayAudioValueControllerScrollEffect(this.duration, this.next);
}

class ShowDialogModeOffEffect extends PlayAudioEffect {
  ShowDialogModeOffEffect();
}

class ShowDialogAddSavedPlaceEffect extends PlayAudioEffect {
  ShowDialogAddSavedPlaceEffect();
}
