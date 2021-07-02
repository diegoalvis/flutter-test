import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile_edit/profile_edit_status.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hive/hive.dart';

class ProfileEditViewModel extends ViewModel<ProfileEditStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

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

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  Future<String> getNameUser() async {

    CurrentUser user = BoxDataSesion.getCurrentUser()!;
    final Person? person = await BoxDataSesion.getFromBox(user.id_db!);

    return person!.name.toString();
  }

  // void goProfilePage() {
  //   _route.goProfile();
  // }

  // Future<void> logOut() async {
  //   await FacebookAuth.instance.logOut();
  //   _route.goLogin();
    // _accessToken = null;
    // _userData = null;
    //setState(() {});
  // }
  void goLoginAll() {
    BoxDataSesion.clearBoxCurrentUser();
    _route.goHome();
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

}
