import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/event_detail/event_detail_status.dart';
import 'package:bogota_app/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailViewModel extends ViewModel<EventDetailStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  EventDetailViewModel(this._route, this._interactor) {
    status = EventDetailStatus(
      isLoading: true,
      moreText: false,
      isFavorite: false
    );
  }

  void onInit() async {
    // TODO
  }

  void readMore(){
    final bool tapClick = status.moreText;
    status = status.copyWith(moreText: !tapClick);
  }

  void onTapFavorite() {
    final bool value = status.isFavorite;
    status = status.copyWith(isFavorite: !value);
  }

 void launchMap(String location) async {
    String longitude = location.split(", ").first;
    String latitude = location.split(", ").last;
    final double lat = double.parse(latitude);
    final double lon = double.parse(longitude);
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error al lanzar la url: $url';
    }
  }


  Future<bool> offMenuBack() async {
    bool? shouldPop = true;
    IdtRoute.route = "";
    return shouldPop;
  }
}
