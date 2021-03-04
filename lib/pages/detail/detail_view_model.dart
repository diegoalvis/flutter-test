import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/detail/detail_status.dart';
import 'package:bogota_app/view_model.dart';

class DetailViewModel extends ViewModel<DetailStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  DetailViewModel(this._route, this._interactor) {
    status = DetailStatus(
      isLoading: true,
      moreText: false,
      openMenuTab: false
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

  void onpenMenuTab() {
    final bool tapClick = status.openMenuTab;
    status = status.copyWith(openMenuTab: !tapClick);
  }

  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

}
