import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/detail/detail_effect.dart';
import 'package:bogota_app/pages/detail/detail_status.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailViewModel extends EffectsViewModel<DetailStatus, DetailEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  DetailViewModel(this._route, this._interactor) {
    status = DetailStatus(
      isLoading: true,
      isFavorite: false,
      moreText: false,
    );
  }

  void readMore() {
    final bool tapClick = status.moreText;
    status = status.copyWith(moreText: !tapClick);
  }

  void goPlayAudioPage(DataPlacesDetailModel _detail) {
    status = status.copyWith(isLoading: true);
    _route.goPlayAudio(detail: _detail);
  }

  void onTapFavorite() {
    final bool value = status.isFavorite;
    status = status.copyWith(isFavorite: !value);
  }

  void onChangeScrollController(bool value, double width) {
    addEffect(DetailControllerScrollEffect(300, width, value));
  }

  void launchCall(String phone) async {
    //Todo
    print('Lamando desde el icono');
    launch(phone);
  }

  void launchMap(String location) async {
    String latitude = location.split(", ").first;
    String longitude = location.split(", ").last;
    final double lat = double.parse(latitude);
    final double lon = double.parse(longitude);
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error al lanzar la url: $url';
    }
  }
}
