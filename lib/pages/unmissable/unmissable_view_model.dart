import 'package:bogota_app/data/model/placesdetail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/unmissable/unmissable_status.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class UnmissableViewModel extends ViewModel<UnmissableStatus> {

  final IdtRoute _route;
  final ApiInteractor

 _interactor;

  UnmissableViewModel(this._route, this._interactor) {
    status = UnmissableStatus(
      isLoading: true,
      openMenu: false
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
}
