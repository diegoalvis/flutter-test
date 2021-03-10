import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/setting/setting_status.dart';
import 'package:bogota_app/view_model.dart';

class SettingViewModel extends ViewModel<SettingStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  SettingViewModel(this._route, this._interactor) {
    status = SettingStatus(
      titleBar: 'Recibidos',
      isLoading: true,
      openMenu: false,
      switchNotification: true
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

  void goProfileEditPage() {
    _route.goProfileEdit();
  }

}
