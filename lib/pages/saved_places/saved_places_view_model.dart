import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/discover/discover_page.dart';
import 'package:bogota_app/pages/home/home_page.dart';
import 'package:bogota_app/pages/saved_places/saved_places_status.dart';
import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:connectivity/connectivity.dart';

class SavedPlacesViewModel extends ViewModel<SavedPlacesStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  SavedPlacesViewModel(this._route, this._interactor) {
    status = SavedPlacesStatus(
        isLoading: true, openMenu: false, listSwitch: [], itemsSavedPlaces: []);
  }

  void onInit() async {
    //TODO
    loadSavedPlaces();
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void loadSavedPlaces() async {
    print("loadSvaedPlaces");

    CurrentUser user = BoxDataSesion.getCurrentUser()!;
    print("user.id_db! ${user.id_db!}");
    Person person = BoxDataSesion.getFromBox(user.id_db!)!;
    var connectivityResult = await (Connectivity().checkConnectivity());

    getSavedPlacesLocalDb(person);

    if (connectivityResult != ConnectivityResult.none) {
      // En caso de haber conexión a internet:
      // - Se cargan los favoritos
      // - Se filtran los lugares que llegan desde el servicio según si están en los lugares guardados localmente
      // - Se Unifica una sola lista, teniendo en cuenta un atributo isLocal que indica si está local o no

      final savedResponse = await _interactor.getSavedPlacesList();
      if (savedResponse is IdtSuccess<List<DataAudioGuideModel>?>) {
        _updatedListSavedPlacesWithItemsOfFavorites(savedResponse.body);
      } else {
        final erroRes = savedResponse as IdtFailure<EatError>;
        print(erroRes.message);
        UnimplementedError();
        // FoodError();
        //Todo implementar errores
      }
    }

    status = status.copyWith(isLoading: false);
  }

  void _updatedListSavedPlacesWithItemsOfFavorites(List<DataAudioGuideModel>? savedResponse) {
    final List<DataAudioGuideModel>? listWithServiceSavedPlaces =
        savedResponse;
    final List<DataAudioGuideModel>? listWithLocalSavedPlaces =
        status.itemsSavedPlaces;
    final List<DataAudioGuideModel> listServiceFinal = [];
    
    if (listWithServiceSavedPlaces != null) {
      listWithServiceSavedPlaces.forEach((element) {
        if (listWithLocalSavedPlaces != null) {
          final index = listWithLocalSavedPlaces
              .indexWhere((itemLocal) => itemLocal.id == element.id);
          if (index != -1) {
            listWithLocalSavedPlaces[index] = element;
            listWithLocalSavedPlaces[index].isLocal = true;
          } else {
            element.isLocal = false;
            listServiceFinal.add(element);
          }
        }
      });
      List<DataAudioGuideModel> list = [
          ...listWithLocalSavedPlaces!,
          ...listServiceFinal
        ];

      list = removeRepeatElementById(list); 
     
      status = status.copyWith(
        itemsSavedPlaces: list,
      );
    }
  }

  List<DataAudioGuideModel> removeRepeatElementById(List<DataAudioGuideModel> list) {
       final Map<String, DataAudioGuideModel> profileMap = new Map();
    list.forEach((DataAudioGuideModel item) => profileMap["${item.id}"] = item);
    list = profileMap.values.toList(); 
    return list;
  }

  void getSavedPlacesLocalDb(Person person) {
    List<DataAudioGuideModel>? data =
        person.detalle as List<DataAudioGuideModel>? ?? [];
    data.forEach((element) => element.isLocal = true);
    status = status.copyWith(itemsSavedPlaces: data);
  }

  void changeSwitch(bool value, int index) {
    // List<bool> list = List.of(status.listSwitch);
    // list[index] = value;
    status.itemsSavedPlaces[index].isLocal = value;
    // status = status.copyWith(listSwitch: list);
    status = status.copyWith(itemsSavedPlaces: status.itemsSavedPlaces);
  }

  void changeSwitch2(String value) {
    List<bool> list = List.of(status.listSwitch);
    status = status.copyWith(listSwitch: list);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  goDetailPage({String? id, DataAudioGuideModel? item}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      print("id de lugares guardados $id");
      status = status.copyWith(isLoading: true);

      final placebyidResponse = await _interactor.getPlaceById(id!);
      print('view model detail page');
      print(placebyidResponse);
      if (placebyidResponse is IdtSuccess<DataPlacesDetailModel?>) {
        print("model detail");
        print(placebyidResponse.body!.title);
        _route.goDetail(isHotel: false, detail: placebyidResponse.body!);

        /// Status reasignacion
        // status.places.addAll(UnmissableResponse.body)
      } else {
        final erroRes = placebyidResponse as IdtFailure<UnmissableError>;
        print(erroRes.message);
        UnimplementedError();
      }
      status = status.copyWith(isLoading: false);
    } else {
      if (item!.isLocal!) {
        // Homologar
        DataPlacesDetailModel payload = DataPlacesDetailModel(
          id: id!,
          title: item.title,
          url_audioguia_en: item.audioguia_en,
          url_audioguia_es: item.audioguia_es,
          url_audioguia_pt: item.audioguia_pt,
          address: "",
          body: "",
          gallery: [],
          ids_subcategories: [],
          location: "",
          rate: "",
          image: item.image,
        );
        _route.goPlayAudio(detail: payload);
        status = status.copyWith(isLoading: false);
      }
    }
  }

    Future<bool> offMenuBack()async {
      bool? shouldPop = true;

      if (status.openMenu) {
        openMenu();
        return !shouldPop;
      } else {
        IdtRoute.route = HomePage.namePage;
        return shouldPop;
      }
    }
}
