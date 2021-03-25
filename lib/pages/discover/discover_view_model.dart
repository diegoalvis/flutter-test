import 'package:bogota_app/data/repository/repository.dart';
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
      openMenuTab: false,
      isZone: false
    );
  }

  void onInit() async {
    // TODO
  }

  void onpenMenu() {
    if (status.openMenu==false){
      status = status.copyWith (openMenu: true);
    }
    else{
      status = status.copyWith(openMenu: false);
    }
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onpenMenuTab({bool isZone = false}) {
    status = status.copyWith(openMenuTab: true, isZone: isZone);
  }

  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  void goFiltersPage(){
    _route.goFilters('Cultura');
    closeMenuTab();
  }

  void goDetailPage() {
    _route.goDetail(isHotel: false);
  }

  void goEventsPage() {
    _route.goEvents(title: 'Dónde dormir', includeDay: false, nameFilter: 'Localidad');
    closeMenuTab();
  }

  void goAudioGuidePage() {
    _route.goAudioGuide();
    closeMenuTab();
  }
}
