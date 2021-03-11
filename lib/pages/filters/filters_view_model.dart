import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/filters/filters_status.dart';
import 'package:bogota_app/view_model.dart';

class FiltersViewModel extends ViewModel<FiltersStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  FiltersViewModel(this._route, this._interactor) {
    status = FiltersStatus(
      isLoading: true,
      openMenu: false,
      openMenuTab: false,
      openMenuFilter: false
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

  void onpenMenuTab() {
    final bool tapClick = status.openMenuTab;
    status = status.copyWith(openMenuTab: !tapClick);
  }

  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false);
  }

  void onpenMenuFilter() {
    final bool tapClick = status.openMenuFilter;
    status = status.copyWith(openMenuFilter: !tapClick);
  }

  void closeMenuFilter() {
    status = status.copyWith(openMenuFilter: false);
  }

  void goDetailPage() {
    _route.goDetail(isHotel: false);
  }
}
