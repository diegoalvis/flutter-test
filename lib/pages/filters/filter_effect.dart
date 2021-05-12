import 'package:bogota_app/view_model.dart';

abstract class FilterEffect extends Effect {

}

class FilterValueControllerScrollEffect extends FilterEffect {
  final int duration;
  final bool next;

  FilterValueControllerScrollEffect(this.duration, this.next);
}

class ShowDialogEffect extends FilterEffect {

  //pasar too lo necesario
  ShowDialogEffect();
}
