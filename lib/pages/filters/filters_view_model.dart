import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/filters/filters_status.dart';
import 'package:bogota_app/utils/errors/food_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class FiltersViewModel extends ViewModel<FiltersStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  FiltersViewModel(this._route, this._interactor) {
    status = FiltersStatus(
      isLoading: true,
      openMenu: false,
      openMenuTab: false,
      openMenuFilter: false,
      filter1: [false, false, false, false, false],
      filter2: [false, false, false, false, false],
      filter3: [false, false, false, false, false],
      itemsFoodPlaces: []
    );
  }

  void onInit() async {
    //TODO
    getFoodResponse();
  }

  void getFoodResponse() async {
    final foodResponse = await _interactor.getFoodPlacesList();

    if (foodResponse is IdtSuccess<List<DataPlacesModel>?>) {
      status = status.copyWith(itemsFoodPlaces: foodResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = foodResponse as IdtFailure<FoodError>;
      print(erroRes.message);
      UnimplementedError();
      // FoodError();
      //Todo implementar errores
    }
    status = status.copyWith(isLoading: false);
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

  void onTapButton(int index, int id) {

    if(id == 1){
      List<bool> filter = List.of(status.filter1);
      filter[index] = !filter[index];
      status = status.copyWith(filter1: filter);
    }
    else if(id == 2){
      List<bool> filter = List.of(status.filter2);
      filter[index] = !filter[index];
      status = status.copyWith(filter2: filter);
    }
    else if(id == 3){
      List<bool> filter = List.of(status.filter3);
      filter[index] = !filter[index];
      status = status.copyWith(filter3: filter);
    }
  }

  void goDetailPage() {
    _route.goDetail(isHotel: false);
  }
}
