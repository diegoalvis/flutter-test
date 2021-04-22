import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/events/events_status.dart';
import 'package:bogota_app/utils/errors/event_error.dart';
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
      itemsEventPlaces: [],
      itemsSleepPlaces: []
    );
  }

  void onInit() async {
    status = status.copyWith(isLoading: true);
    //TODO
    getEventResponse();
    getSleepsResponse();
  }

  void getEventResponse() async {
    final eventResponse = await _interactor.getEventPlacesList();

    if (eventResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(itemsEventPlaces: eventResponse.body);// Status reasignacion

      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = EventError as IdtFailure<EventError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void getSleepsResponse() async {
    final sleepResponse = await _interactor.getSleepPlacesList();

    if (sleepResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(itemsSleepPlaces: sleepResponse.body);// Status reasignacion

      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = EventError as IdtFailure<EventError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
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
  //  _route.goDetail(isHotel: true);
  }

  void goDetailEventPage() {
    _route.goEventsDetail();
  }

}
