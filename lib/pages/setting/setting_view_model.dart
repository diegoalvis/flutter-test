import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/setting/setting_status.dart';
import 'package:bogota_app/view_model.dart';

class SettingViewModel extends ViewModel<SettingStatus> {

  final IdtRoute _route;
  final PlaceRepository

 _interactor;

  SettingViewModel(this._route, this._interactor) {
    status = SettingStatus(
      titleBar: 'Recibidos',
      isLoading: true,
      openMenu: false,
      switchNotification: true,
      switchNotification2: false,
    );
  }

  void onInit() async {
    //TODO
  }

  void onpenMenu() {
    status = status.copyWith(openMenu: true);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void changeNotification(bool value) {
    status = status.copyWith(switchNotification: value);
  }

  void changeNotification2(bool value) {
    status = status.copyWith(switchNotification2: value);
  }

  void goProfileEditPage() {
    _route.goProfileEdit();
  }

}
