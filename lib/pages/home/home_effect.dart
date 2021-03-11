import 'package:bogota_app/view_model.dart';

abstract class HomeEffect extends Effect {

}
class ValueControllerScrollEffect extends HomeEffect {
  final int duration;
  final bool next;

  ValueControllerScrollEffect(this.duration, this.next);
}