import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/favorite_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/unmissable/unmissable_status.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class UnmissableViewModel extends ViewModel<UnmissableStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  List<DataModel> unmissable = [];

  UnmissableViewModel(this._route, this._interactor) {
    status = UnmissableStatus(
        isLoading: true,
        openMenu: false,
        itemsUnmissablePlaces: [],
        itemsbestRatedPlaces: [],
        currentOption: 0);
  }

  void onInit() async {
    getUnmissableResponse();
    // TODO
  }

  void getUnmissableResponse({int? option}) async {
    status = status.copyWith(isLoading: true, currentOption: 0);
    print('entra unmmisable');
    final IdtResult<List<DataModel>?> unmissableResponse =
        await _interactor.getUnmissablePlacesList();

    if (unmissableResponse is IdtSuccess<List<DataModel>?>) {
      print(unmissableResponse.body![0].title);
      status = status.copyWith(
          itemsUnmissablePlaces:
              unmissableResponse.body); // Status reasignacion

      // Actualización de lugares guardados/favoritos
      try {
        final dynamic savedPlaces = await _interactor.getSavedPlacesList();
        if (savedPlaces is IdtSuccess<List<DataAudioGuideModel>?>) {
          List places = savedPlaces.body!;
          unmissableResponse.body!.map((unmissable) {
            try {
              final DataAudioGuideModel lugarIsFavoriteSaved =
                  places.firstWhere((element) => element.id == unmissable.id);
              if (lugarIsFavoriteSaved != null) {
                unmissable.isFavorite = true;
              }
            } catch (e) {
              unmissable.isFavorite = false;
            }
            return unmissable;
          }).toList();
        }
        status = status.copyWith(
            isLoading: false, itemsUnmissablePlaces: unmissableResponse.body);
      } catch (e) {
        // Permite fluir el flujo en caso de error
      }
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = unmissableResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void getBestRatedResponse({int? option}) async {
    status = status.copyWith(isLoading: true, currentOption: 1);
    final bestRatedResponse = await _interactor.getBestRatedPlacesList();

    if (bestRatedResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(
          itemsUnmissablePlaces: bestRatedResponse.body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = bestRatedResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
      // FoodError();
      //Todo implementar errores
    }
    status = status.copyWith(isLoading: false);
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  goDetailPage(String id) async {
    //  _route.goDetail(isHotel: false, id:id);

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
  }

  onTapFavorite(String idplace) async {
    late int value = status.itemsUnmissablePlaces.indexWhere((element) => element.id == idplace);
    print("idplace");
    print(idplace);
    final favoriteResponse = await _interactor.postFavorite(idplace);
    if (favoriteResponse is IdtSuccess<FavoriteModel?>) {
      print(favoriteResponse.body!.message);
    }

    status = status.copyWith(isLoading: false);
    status.itemsUnmissablePlaces[value].isFavorite = !status.itemsUnmissablePlaces[value].isFavorite!;
    status = status.copyWith(itemsUnmissablePlaces: status.itemsUnmissablePlaces);
  }
}
