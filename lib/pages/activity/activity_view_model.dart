import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/pages/activity/activity_status.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';

class ActivityViewModel extends ViewModel<ActivityStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  ActivityViewModel(this._route, this._interactor) {
    status = ActivityStatus(
      detail: [],
      isHotel: false,
      isLoading: false,
      openMenu: false,
      openMenuTab: false,
      listOptions: [],
      section: '',
    );
  }

  void onInit() async {}

  void goActivityPage() async {
    status = status.copyWith(isLoading: true);
    await _route.goActivity();
    status = status.copyWith(isLoading: false);
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void openMenuTab(
      List<DataModel> listData, String section, int currentOption) {
    status = status.copyWith(
        openMenuTab: true,
        listOptions: listData,
        section: section,
        currentOption: currentOption);
  }

  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false, currentOption: -1);
  }

  getPlacesVisitedStorageLocal() {
    try {
      CurrentUser user = BoxDataSesion.getCurrentUser()!;
      if (user.id_user != null) {
        List<dynamic> list = BoxDataSesion.getListActivity(user.id_user!);
        status = status.copyWith(detail: list as List<DataPlacesDetailModel>?);
      }
    } catch (e) {}
  }

  goDetailPage(String id) async {
    status = status.copyWith(isLoading: true);

    final placebyidResponse = await _interactor.getPlaceById(id);
    print('view model detail page');
    print(placebyidResponse);
    if (placebyidResponse is IdtSuccess<DataPlacesDetailModel?>) {
      print("model detail");
      print(placebyidResponse.body!.title);
      _route.goEventDetail(detail: placebyidResponse.body!);

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
