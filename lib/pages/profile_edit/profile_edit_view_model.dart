import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/data_as_message_model.dart';
import 'package:bogota_app/data/model/response/delete_user_response.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile_edit/profile_edit_status.dart';
import 'package:bogota_app/pages/profile_edit/profile_effect.dart';
import 'package:bogota_app/utils/errors/error_model.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';


class ProfileEditViewModel extends  EffectsViewModel<ProfileEditStatus, ProfileEditEffect>  {

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
  Future<void> goLoginAll() async {
    BoxDataSesion.clearBoxCurrentUser();

    try{
      RememberMe? remember = await BoxDataSesion.getFromRememberBox(0);
      print("valores recuperados para cerrar sesión ${remember!.state}, ${remember!.email}");
      if(remember!.state == true){

      }
    }catch(e){
      BoxDataSesion.clearBoxRememberMe();
    }


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



  Future<bool> deleteUser() async {
    status = status.copyWith(isLoading: true);
    CurrentUser user = BoxDataSesion.getCurrentUser()!;
    final deleteResponse = await _interactor.deleteUser(user.id_user!);
  
    if (deleteResponse is IdtSuccess<DataAsMessageModel?>) {
      return true;
    } else {
      final erroRes = deleteResponse as IdtFailure<ErrorModel>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
    return false;
  }
}
