import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/saved_places/saved_places_status.dart';
import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class SavedPlacesViewModel extends ViewModel<SavedPlacesStatus> {

  final IdtRoute _route;
  final ApiInteractor

 _interactor;

  SavedPlacesViewModel(this._route, this._interactor) {
    status = SavedPlacesStatus(
      isLoading: true,
      openMenu: false,
      listSwitch: [],
      itemsSavedPlaces: []
    );
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
    final savedResponse = await _interactor.getSavedPlacesList();

    if (savedResponse is IdtSuccess<List<DataModel>?>) {

      List<bool> list = List.filled(savedResponse.body!.length, false);
      status = status.copyWith(listSwitch: list);

      status = status.copyWith(itemsSavedPlaces: savedResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = savedResponse as IdtFailure<EatError>;
      print(erroRes.message);
      UnimplementedError();
      // FoodError();
      //Todo implementar errores
    }
    status = status.copyWith(isLoading: false);
    //addEffect(ShowDialogEffect());  Dialog de prueba
  }


  void changeSwitch(bool value, int index) {

    List<bool> list = List.of(status.listSwitch);
    list[index] = value;
    status = status.copyWith(listSwitch: list);
  }

  void changeSwitch2(String value) {

    List<bool> list = List.of(status.listSwitch);
    status = status.copyWith(listSwitch: list);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  goDetailPage(String id) async{

    print("id de lugares guardados $id");
    status = status.copyWith(isLoading: true);

    final placebyidResponse = await _interactor.getPlaceById(id);
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


    //_route.goDetail(isHotel: false);
  }
}
