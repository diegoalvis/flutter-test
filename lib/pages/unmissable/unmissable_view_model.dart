import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/unmissable/unmissable_status.dart';
import 'package:bogota_app/view_model.dart';

class UnmissableViewModel extends ViewModel<UnmissableStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  UnmissableViewModel(this._route, this._interactor) {
    status = UnmissableStatus(
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

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }
}
