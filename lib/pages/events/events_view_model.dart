import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/events/events_status.dart';
import 'package:bogota_app/utils/errors/food_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class EventsViewModel extends ViewModel<EventsStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  EventsViewModel(this._route, this._interactor) {
    status = EventsStatus(
      isLoading: true,
      openMenu: false,
      openMenuTab: false,
      itemsSleepPlaces: []
    );
  }

  void onInit() async {

    print("entra a events");
    //TODO
    getSleepResponse();
  }

  void getSleepResponse() async {
    final sleepResponse = await _interactor.getSleepPlacesList();

    if (sleepResponse is IdtSuccess<List<DataPlacesModel>?>) {
      status = status.copyWith(itemsSleepPlaces: sleepResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = sleepResponse as IdtFailure<FoodError>;
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

  void onTapDrawer(String type) {
    status = status.copyWith(isLoading: true);
  }

  void goDetailPageHotel()  {
    _route.goDetail(isHotel: true);
  }

  void goDetailEventPage() {
    _route.goEventsDetail();
  }

}
