import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile/profile_status.dart';
import 'package:bogota_app/utils/errors/user_data_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class ProfileViewModel extends ViewModel<ProfileStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  ProfileViewModel(this._route, this._interactor) {
    status = ProfileStatus(
      titleBar: 'Recibidos',
      isLoading: true,
      openMenu: false,
      dataUser: null,

    );
  }

  final int idUserTest = 290;

  void onInit() async {
    status = status.copyWith(isLoading: true);
    getDataUser(idUserTest.toString());
  }

  void getDataUser(String id) async {
    print('obteniendo datos del Usuario');
    final dataUser = await _interactor.getDataUser(id);
    if (dataUser is IdtSuccess<UserModel?>) {
      print('Email del Usario id $idUserTest:** ${dataUser.body!.name}');

      status = status.copyWith(dataUser: dataUser.body); // Status reasignacion
      print(status.dataUser!.toJson());
    } else {
      final erroRes = dataUser as IdtFailure<UserDataError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void goProfileEditPage() async {
    status = status.copyWith(isLoading: true);
    //todo se debe cambiar una vez el correo llegue para el servicio de obtener usuario
    //status.dataUser!.email!,
    await _route.goProfileEdit(status.dataUser!.name!,status.dataUser!.lastName!);
  }

  void goSettingPage() {
    _route.goSettings();
  }
}
