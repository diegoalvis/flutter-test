import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile/profile_status.dart';
import 'package:bogota_app/view_model.dart';

class ProfileViewModel extends ViewModel<ProfileStatus> {

  final IdtRoute _route;
  final ApiInteractor

 _interactor;

  ProfileViewModel(this._route, this._interactor) {
    status = ProfileStatus(
      titleBar: 'Recibidos',
      isLoading: true,
      openMenu: false
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

  void goProfileEditPage() {
    _route.goProfileEdit();
  }

  void goSettingPage() {
    _route.goSettings();
  }

}
