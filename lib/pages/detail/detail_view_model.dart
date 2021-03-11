import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/detail/detail_effect.dart';
import 'package:bogota_app/pages/detail/detail_status.dart';
import 'package:bogota_app/view_model.dart';

class DetailViewModel extends EffectsViewModel<DetailStatus, DetailEffect> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  DetailViewModel(this._route, this._interactor) {
    status = DetailStatus(
      isLoading: true,
      moreText: false,
      isFavorite: false
    );
  }

  void onInit() async {
    //TODO
  }

  void readMore(){
    final bool tapClick = status.moreText;
    status = status.copyWith(moreText: !tapClick);
  }

  void goPlayAudioPage() {
    _route.goPlayAudio();
  }

  void onTapFavorite() {
    final bool value = status.isFavorite;
    status = status.copyWith(isFavorite: !value);
  }

  void onChangeScrollController(bool value, double width){
    addEffect(DetailControllerScrollEffect(300, width, value));
  }

}
