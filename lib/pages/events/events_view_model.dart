import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/events/events_status.dart';
import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/event_error.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

import 'events_effect.dart';

enum SocialEventType { EVENT, SLEEP, EAT }

class EventsViewModel extends EffectsViewModel<EventsStatus, EventsEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  final SocialEventType type;

  EventsViewModel(this._route, this._interactor, this.type) {
    status = EventsStatus(
      isLoading: true,
      openMenu: false,
      openMenuTab: false,
      title: '',
      section: '',
      nameFilter: 'Localidad',
      places: [],
      zones: [],
    );
  }

  void onInit() async {
    getZonesResponse();

    late String title, nameFilter, section;
    switch (type) {
      case SocialEventType.EVENT:
        title = 'Evento';
        nameFilter = 'Todos';
        section = 'event';
        getEventResponse();
        break;
      case SocialEventType.SLEEP:
        title = 'Dónde dormir';
        section = 'hotel';
        nameFilter = 'Localidad';
        getSleepsResponse();
        break;
      case SocialEventType.EAT:
        title = 'Dónde comer';
        section = 'food';
        nameFilter = 'Localidad';
        getEatResponse();
    }
    status = status.copyWith(
      isLoading: true,
      title: title,
      section: section,
      nameFilter: nameFilter,
    );
    // llamar metodo que obtiene las localidades
  }

  void getZonesResponse() async {
    status = status.copyWith(isLoading: true);

    final zonesResponse = await _interactor.getZonesList();

    if (zonesResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(zones: zonesResponse.body); // Status reasignacion
    } else {
      final erroRes = EventError as IdtFailure<EventError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void filtersForZones(DataModel item, String section) async {
    status = status.copyWith(isLoading: true);

    final Map query = {'zone' : item.id};
    // print('1. $query');


    final response = await _interactor.getPlaceEventForLocation(query, section);
    if (response is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(places: response.body, nameFilter: item.title!); // Status reasignacion

    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    closeMenuTab();
    status = status.copyWith(isLoading: false);
    if (status.places.length < 1) {
      addEffect(ShowDialogEffect());
    }
  }

  void getEventResponse() async {
    final eventResponse = await _interactor.getEventPlacesList();

    if (eventResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(places: eventResponse.body); // Status reasignacion

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
      status = status.copyWith(places: sleepResponse.body); // Status reasignacion

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
      status = status.copyWith(places: eatResponse.body); // Status reasignacion

    } else {
      final erroRes = EventError as IdtFailure<EatError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void openMenuTab(
    List<DataModel> listData,
    // String section, int currentOption
  ) {
    status = status.copyWith(
      openMenuTab: !status.openMenuTab,
      zones: listData,
      // section: section,
      // currentOption: currentOption,
    );
  }

  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false);
  }

  void onTapDrawer(String type) {
    //Esto para que sirve??
    status = status.copyWith(isLoading: true);
  }

  goDetailPage(String id, SocialEventType type) async {
    status = status.copyWith(isLoading: true);
    final placeByIdResponse;

    switch (type) {
      case SocialEventType.EVENT:
        placeByIdResponse = await _interactor.getEventSocialById(id);
        if (placeByIdResponse is IdtSuccess<DataPlacesDetailModel?>) {
          _route.goEventDetail(detail: placeByIdResponse.body!);
        } else {
          final erroRes = placeByIdResponse as IdtFailure<UnmissableError>;
          print(erroRes.message);
          UnimplementedError();
        }
        status = status.copyWith(isLoading: false);
        break;
      case SocialEventType.SLEEP:
        placeByIdResponse = await _interactor.getSleepSocialById(id);
        if (placeByIdResponse is IdtSuccess<DataPlacesDetailModel?>) {
          _route.goDetail(detail: placeByIdResponse.body!, isHotel: true);
        } else {
          final erroRes = placeByIdResponse as IdtFailure<UnmissableError>;
          print(erroRes.message);
          UnimplementedError();
        }
        status = status.copyWith(isLoading: false);
        break;
      case SocialEventType.EAT:
        placeByIdResponse = await _interactor.getEatSocialById(id);
        if (placeByIdResponse is IdtSuccess<DataPlacesDetailModel?>) {
          _route.goDetail(detail: placeByIdResponse.body!, isHotel: false);
        } else {
          final erroRes = placeByIdResponse as IdtFailure<UnmissableError>;
          print(erroRes.message);
          UnimplementedError();
        }
        status = status.copyWith(isLoading: false);
        break;
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

  Future<bool> offMenuBack()async {
    bool? shouldPop = true;

    if (status.openMenu) {
      openMenu();
      return !shouldPop;
    } else {
      return shouldPop;
    }
  }
}
