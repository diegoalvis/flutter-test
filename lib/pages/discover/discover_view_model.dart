import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/discover/discover_status.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class DiscoverViewModel extends ViewModel<DiscoverStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  List<DataModel> places = [];
  List<DataModel> categories = [];
  List<DataModel> subcategories = [];
  List<DataModel> zones = [];

  DiscoverViewModel(this._route, this._interactor) {
    status = DiscoverStatus(
        isLoading: false,
        openMenu: false,
        openMenuTab: false,
        listOptions: [],
        section: '');
  }

  void onInit() async {
    // TODO
  }

  void openMenu() {
      status = status.copyWith(openMenu: !status.openMenu);

  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void openMenuTab(List<DataModel> listData, String section, int currentOption) {
    status = status.copyWith(
        openMenuTab: true, listOptions: listData, section: section, currentOption: currentOption);
  }

  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false, currentOption: -1);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  void goFiltersPage(DataModel item, List<DataModel> categories, List<DataModel> subcategories,
      List<DataModel> zones) async {
    status = status.copyWith(isLoading: true);
    final Map query = {status.section: item.id};

    final response = await _interactor.getPlacesList(query);

    if (response is IdtSuccess<List<DataModel>?>) {
      final places = response.body!;
      _route.goFilters(
          section: status.section,
          item: item,
          categories: categories,
          subcategories: subcategories,
          zones: zones,
          places: places
      );
    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    closeMenuTab();
    status = status.copyWith(isLoading: false);
  }

  void getDiscoveryData() async {
    status = status.copyWith(isLoading: true);

    bool isValid = true;

    final resPlaces = await _interactor.getPlacesList({});

    if (resPlaces is IdtSuccess<List<DataModel>?>) {
      places = resPlaces.body!;
    } else {
      isValid = false;
      final erroRes = resPlaces as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }

    final resCategory = await _interactor.getCategoriesList();

    if (resCategory is IdtSuccess<List<DataModel>?>) {
      categories = resCategory.body!;
    } else {
      isValid = false;
      final erroRes = resCategory as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }

    final resSubcategiry = await _interactor.getSubcategoriesList();

    if (resSubcategiry is IdtSuccess<List<DataModel>?>) {
      subcategories = resSubcategiry.body!;
    } else {
      isValid = false;
      final erroRes = resSubcategiry as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }

    final resZona = await _interactor.getZonesList();

    if (resZona is IdtSuccess<List<DataModel>?>) {
      zones = resZona.body!;
    } else {
      isValid = false;
      final erroRes = resZona as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }

    status = status.copyWith(isLoading: false);

    if (!isValid) {
      _route.pop();
    }
  }

   goDetailPage(String id) async {
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

  void goAudioGuidePage() {
    _route.goAudioGuide(1);
    closeMenuTab();
  }
}
