import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/setting/setting_status.dart';
import 'package:bogota_app/view_model.dart';
import 'package:app_settings/app_settings.dart';
import 'package:location/location.dart';

class SettingViewModel extends ViewModel<SettingStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

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

  void changeNotification(bool value) async{
    status = status.copyWith(switchNotification: value);
    AppSettings.openNotificationSettings(asAnotherTask: false);
  }

  void changeNotificationValue(bool value) async{
    status = status.copyWith(switchNotification: value);
  }

  void changeLocationPermissions(bool value) async {
    status = status.copyWith(switchNotification2: value);
    AppSettings.openLocationSettings();
  }

  void changeLocationValue(bool value) async {
    status = status.copyWith(switchNotification2: value);
  }

  Future<bool> offMenuBack()async {
    bool? shouldPop = true;

    if (status.openMenu) {
      openMenu();
      return !shouldPop;
    } else {
      return shouldPop;
    }
  }


// void goProfileEditPage() {
  //   _route.goProfileEdit();
  // }

  void goActivity() {
    _route.goActivity();
  }

  void goSavedPlaces() {
    _route.goSavedPlaces();
  }
}
