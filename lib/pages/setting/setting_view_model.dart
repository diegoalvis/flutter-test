import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/setting/setting_status.dart';
import 'package:bogota_app/view_model.dart';
import 'package:app_settings/app_settings.dart';
import 'package:location/location.dart';
class SettingViewModel extends ViewModel<SettingStatus> {

  final IdtRoute _route;
  final ApiInteractor

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
  Location locationUser = Location();
  void onInit() async {
    //TODO
    status.switchNotification2 = await locationUser.serviceEnabled();
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void changeNotification(bool value) {
    status = status.copyWith(switchNotification: value);
  }

  void changeNotification2(bool value) async {
    print('ubicación');

    status = status.copyWith(switchNotification2: value);
    AppSettings.openLocationSettings();
    bool _serviceEnabled = await locationUser.serviceEnabled();
    if(_serviceEnabled){
      status = status.copyWith(switchNotification2: false);
    }else{
      status = status.copyWith(switchNotification2: true);
    }


  }

  // void goProfileEditPage() {
  //   _route.goProfileEdit();
  // }

}
