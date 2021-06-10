import 'package:bogota_app/view_model.dart';

abstract class EventsEffect extends Effect {

}

class EventsValueControllerScrollEffect extends EventsEffect {
  final int duration;
  final bool next;

  EventsValueControllerScrollEffect(this.duration, this.next);
}

class ShowDialogEffect extends EventsEffect {

  //pasar too lo necesario
  ShowDialogEffect();
}
