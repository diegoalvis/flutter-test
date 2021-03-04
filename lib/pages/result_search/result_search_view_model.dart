import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/result_search/result_search_status.dart';
import 'package:bogota_app/view_model.dart';

class ResultSearchViewModel extends ViewModel<ResultSearchStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  ResultSearchViewModel(this._route, this._interactor) {
    status = ResultSearchStatus(
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

  void goFiltersPage(){
    _route.goFilters();
  }
}
