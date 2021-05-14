import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/saved_places/saved_places_status.dart';
import 'package:bogota_app/view_model.dart';

class SavedPlacesViewModel extends ViewModel<SavedPlacesStatus> {

  final IdtRoute _route;
  final ApiInteractor

 _interactor;

  SavedPlacesViewModel(this._route, this._interactor) {
    status = SavedPlacesStatus(
      isLoading: true,
      openMenu: false,
      listSwitch: [false, false, false, false, false, false, false, false, false, false]
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

  void changeSwitch(bool value, int index) {

    List<bool> list = List.of(status.listSwitch);
    list[index] = value;
    status = status.copyWith(listSwitch: list);
  }

  void changeSwitch2(String value) {

    List<bool> list = List.of(status.listSwitch);
    status = status.copyWith(listSwitch: list);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  void goDetailPage(){
    //_route.goDetail(isHotel: false);
  }
}
