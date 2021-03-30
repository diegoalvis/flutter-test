import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/discover/discover_status.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class DiscoverViewModel extends ViewModel<DiscoverStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  DiscoverViewModel(this._route, this._interactor) {
    status = DiscoverStatus(
      isLoading: true,
      openMenu: false,
      openMenuTab: false,
      listOptions: [],
      section: ''
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

  void onpenMenuTab(List<DataModel> listData, String section) {
    status = status.copyWith(openMenuTab: true, listOptions: listData, section: section);
  }

  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  void goFiltersPage(DataModel item, List<DataModel> categories,
      List<DataModel> subcategories, List<DataModel> zones) async {

    final Map query = {
      status.section : item.id
    };

    final response = await _interactor.getPlacesList([query]);

    if (response is IdtSuccess<List<DataModel>?>) {
      final places = response.body!;
      print('PLaces: $places');
      _route.goFilters(section: status.section, item: item, categories: categories, subcategories: subcategories, zones: zones, places: places);
    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
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
