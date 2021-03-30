import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/search/search_status.dart';
import 'package:bogota_app/view_model.dart';

class SearchViewModel extends ViewModel<SearchStatus> {

  final IdtRoute _route;
  final ApiInteractor

 _interactor;

  SearchViewModel(this._route, this._interactor) {
    status = SearchStatus(
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

  void goResultSearchPage(){
    _route.goResultSearch();
  }
}
