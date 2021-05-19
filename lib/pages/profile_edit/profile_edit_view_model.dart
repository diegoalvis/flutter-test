import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile_edit/profile_edit_status.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class ProfileEditViewModel extends ViewModel<ProfileEditStatus> {

  final IdtRoute _route;
  final ApiInteractor

 _interactor;

  ProfileEditViewModel(this._route, this._interactor) {
    status = ProfileEditStatus(
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

  void goProfilePage() {
    _route.goProfile();
  }

  Future<void> logOut() async {
    await FacebookAuth.instance.logOut();
    _route.goLogin();
    // _accessToken = null;
    // _userData = null;
    //setState(() {});
  }

}

