import 'package:bogota_app/view_model.dart';

abstract class SearchEffect extends Effect {

}

class SearchValueControllerScrollEffect extends SearchEffect {
  final int duration;
  final bool next;

  SearchValueControllerScrollEffect(this.duration, this.next);
}

class ShowDialogEffect extends SearchEffect {

  //pasar too lo necesario
  ShowDialogEffect();
}
