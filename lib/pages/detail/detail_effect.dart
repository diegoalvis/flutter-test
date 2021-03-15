import 'package:bogota_app/view_model.dart';

abstract class DetailEffect extends Effect {

}

class DetailControllerScrollEffect extends DetailEffect {
  final int duration;
  final double width;
  final bool next;

  DetailControllerScrollEffect(this.duration, this.width, this.next);
}