import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/discover/discover_status.dart';
import 'package:bogota_app/view_model.dart';

class DiscoverViewModel extends ViewModel<DiscoverStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  DiscoverViewModel(this._route, this._interactor) {
    status = DiscoverStatus(
      isLoading: true,
      openMenu: false,
      openMenuTab: false
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

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  void goFiltersPage(){
    _route.goFilters('Cultura');
  }
}
