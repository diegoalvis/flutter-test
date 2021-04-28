import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_social_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/events/events_status.dart';
import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/event_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

enum SocialEventType { EVENT, SLEEP, EAT }

class EventsViewModel extends ViewModel<EventsStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  final SocialEventType type;

  EventsViewModel(this._route, this._interactor, this.type) {
    status = EventsStatus(
        isLoading: true,
        openMenu: false,
        openMenuTab: false,
        itemsPlaces: [],
        title: '',
        nameFilter: 'TODOS');
  }

  void onInit() async {
    late String title, nameFilter;
    switch (type) {
      case SocialEventType.EVENT:
        title = 'Evento';
        nameFilter = 'Todos';
        getEventResponse();
        break;
      case SocialEventType.SLEEP:
        title = 'Dónde dormir';
        nameFilter = 'Localidad';
        getSleepsResponse();
        break;
      case SocialEventType.EAT:
        title = 'Dónde comer';
        nameFilter = 'Localidad';
        getEatResponse();
    }
    status = status.copyWith(
      isLoading: true,
      title: title,
      nameFilter: nameFilter,
    );
  }

  void getEventResponse() async {
    final eventResponse = await _interactor.getEventPlacesList();

    if (eventResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(itemsPlaces: eventResponse.body); // Status reasignacion

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
      status = status.copyWith(itemsPlaces: sleepResponse.body); // Status reasignacion

    } else {
      final erroRes = EventError as IdtFailure<EventError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void getEatResponse() async {
    final eatResponse = await _interactor.getEatPlacesList();

    if (eatResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(itemsPlaces: eatResponse.body); // Status reasignacion

    } else {
      final erroRes = EventError as IdtFailure<EatError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void onpenMenu() {
    if (status.openMenu == false) {
      status = status.copyWith(openMenu: true);
    } else {
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
    //Esto para que sirve??
    status = status.copyWith(isLoading: true);
  }

  goDetailSocialPage(String id) async {
    status = status.copyWith(isLoading: true);

    final placeEventbyIdResponse = await _interactor.getPlaceSocialById(id);
    if (placeEventbyIdResponse is IdtSuccess<DataPlacesSocialDetailModel?>) {
      print('Titulo del evento: ${placeEventbyIdResponse.body!.title}');
      _route.goEventsDetail(detail: placeEventbyIdResponse.body!);
    } else {
      final erroRes = placeEventbyIdResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  String getImageUrl(DataModel value) {
    //determina la Key, para hacer el adecuado solicitud de la imagen
    late String? imageUrl;
    switch (type) {
      case SocialEventType.EVENT:
        imageUrl = value.coverImage;
        break;
      case SocialEventType.SLEEP:
        imageUrl = value.image;
        break;
      case SocialEventType.EAT:
        imageUrl = value.image;
        break;
    }
    return IdtConstants.url_image + (imageUrl ?? ''); //hay alguna imagen por defecto?
  }
}
