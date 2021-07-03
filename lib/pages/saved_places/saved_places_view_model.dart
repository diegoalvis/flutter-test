import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/saved_places/saved_places_status.dart';
import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:connectivity/connectivity.dart';

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
    print("loadSvaedPlaces");

    CurrentUser user = BoxDataSesion.getCurrentUser()!;
    print("user.id_db! ${user.id_db!}");
    Person person = BoxDataSesion.getFromBox(user.id_db!)!;
    var connectivityResult = await (Connectivity().checkConnectivity());
    print("connectivityResult saved_places $connectivityResult");

    if(connectivityResult == ConnectivityResult.none){
      print("no internet $person.");
      List<DataAudioGuideModel> detail = person.detalle!;
      print(detail[0].id);
      List<bool> list = List.filled((person.detalle!).length, false);
      status = status.copyWith(listSwitch: list);
      print("list $list");
      print("person.detalle ${detail.length}");

     // final entity = DataAudioGuideModel.fromJson(person.detalle);

      List<DataAudioGuideModel>? data = person.detalle as List<DataAudioGuideModel>?;
      print("data $data");
      status = status.copyWith(itemsSavedPlaces: data);
      print("status.itemsSavedPlaces ${status.itemsSavedPlaces}");

    }else{
      print("internet");
      final savedResponse = await _interactor.getSavedPlacesList();
      if (savedResponse is IdtSuccess<List<DataAudioGuideModel>?>) {
        List<bool> listAudio=[];
        print("savedResponse.body!.length ${savedResponse.body!.length}");

        var datos = Map();
        for(final f in savedResponse.body!) {
          print("entra a for");
          print(person.audioguias);

          //      final  lugarIsFavoriteSaved = savedResponse.body!.firstWhere((element) => element.id == person.audioguias![element.id]);

          try{
            var index =0;
            print("person.audioguias! ${person.audioguias!}");
            if(person.audioguias! != null){
              for (final e in person.audioguias!){
                print("index $index");
                if (e![(int.parse(f.id!)).toString()] != null ) {
                  listAudio.add(true);
                }else{

                  if(listAudio[index]== true){
                  }else{
                    listAudio.add(false);
                  }
                  //listAudio.add(false);
                }
                index+1;
              }
            }
          }
          catch(e) {
            listAudio = List.filled(savedResponse.body!.length, false);
            print(listAudio.length);
          }

        }
        print(listAudio);

        List<bool> list = List.filled(savedResponse.body!.length, false);
        status = status.copyWith(listSwitch: listAudio);

        status = status.copyWith(itemsSavedPlaces: savedResponse.body); // Status reasignacion
        // status.places.addAll(UnmissableResponse.body)


      } else {
        final erroRes = savedResponse as IdtFailure<EatError>;
        print(erroRes.message);
        UnimplementedError();
        // FoodError();
        //Todo implementar errores
      }
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
