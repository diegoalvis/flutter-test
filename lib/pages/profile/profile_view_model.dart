import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile/profile_status.dart';
import 'package:bogota_app/view_model.dart';

class ProfileViewModel extends ViewModel<ProfileStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

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

  void getDataUser() async {
    print('obteniendo datos del Usuario');
    final dataUser = await _interactor.getUnmissablePlacesList();

    if (unmissableResponse is IdtSuccess<List<DataModel>?>) {
      print(unmissableResponse.body![0].title);
      status = status.copyWith(itemsUnmissablePlaces: unmissableResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = unmissableResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
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
