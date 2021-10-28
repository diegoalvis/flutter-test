import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/discover/discover_status.dart';
import 'package:bogota_app/pages/home/home_page.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class DiscoverViewModel extends ViewModel<DiscoverStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  late String languageUser;
  Location location = new Location();
  String latitud = '';
  String longitud = '';

  DiscoverViewModel(this._route, this._interactor) {
    status = DiscoverStatus(
      isLoading: false,
      openMenu: false,
      openMenuTab: false,
      zones: [],
      subcategories: [],
      categories: [],
      places: [],
      listOptions: [],
      section: '',
    );
  }


  void onInit() async {
    getDiscoveryData();
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

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    latitud = _locationData.latitude.toString();
    longitud = _locationData.longitude.toString();
  }

  void goFiltersPage(DataModel item, List<DataModel> categories,
      List<DataModel> subcategories, List<DataModel> zones) async {
    languageUser = BoxDataSesion.getLaguageByUser();
    status = status.copyWith(isLoading: true);

    late Map<String,String> query;

    if (status.section == 'subcategory') {
      final itemsSubCat =
          await _interactor.getPlacesSubcategory(item.id, languageUser);

      if (itemsSubCat is IdtSuccess<List<DataModel>?>) {
        final listIds = itemsSubCat.body!.map((e) => e.id).toList().join(",");
        query = {status.section: listIds};
      }
    } else {
      query = {status.section: item.id};
    }
    //todo Aqui si se arma bien las subCategorias
    final response = await _interactor.getPlacesListGoFilter(query, languageUser);
    // await getLoc();
    // final response = await _interactor.getPlacesCloseToMe('$latitud,$longitud',languageUser);

    if (response is IdtSuccess<List<DataModel>?>) {
      final places = response.body!;
      _route.goFilters(
          section: status.section,
          item: item,
          categories: categories,
          subcategories: subcategories,
          zones: zones,
          places: places,
          oldFilters: query);
    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    closeMenuTab();
    status = status.copyWith(isLoading: false);
  }

  void getDiscoveryData() async {
    languageUser = BoxDataSesion.getLaguageByUser();
    status = status.copyWith(isLoading: true);

    void sortOptionsFilters(IdtSuccess<List<DataModel>?> resources) {
      //ordena los filtros A/Z
      resources.body!.sort((a, b) => a.title!.compareTo(b.title!));
    }

    bool isValid = true;

    //final resPlaces = await _interactor.getPlacesList({});
    final resPlaces = await _interactor.getBestRatedPlacesList(languageUser);

    if (resPlaces is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(places: resPlaces.body!);
    } else {
      isValid = false;
      final erroRes = resPlaces as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    final resCategory = await _interactor.getCategoriesList(languageUser);

    if (resCategory is IdtSuccess<List<DataModel>?>) {
      sortOptionsFilters(resCategory);
      resCategory.body!.sort((a, b) => a.title!.compareTo(b.title!));

      status = status.copyWith(categories: resCategory.body);
    } else {
      isValid = false;
      final erroRes = resCategory as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }

    final resSubcategiry = await _interactor.getSubcategoriesList(languageUser);

    if (resSubcategiry is IdtSuccess<List<DataModel>?>) {
      sortOptionsFilters(resSubcategiry);

      status = status.copyWith(subcategories: resSubcategiry.body);
    } else {
      isValid = false;
      final erroRes = resSubcategiry as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }

    final resZona = await _interactor.getZonesList(languageUser);

    if (resZona is IdtSuccess<List<DataModel>?>) {
      sortOptionsFilters(resZona);
      status = status.copyWith(zones: resZona.body);
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
    languageUser = BoxDataSesion.getLaguageByUser();
    status = status.copyWith(isLoading: true);

    final placebyidResponse = await _interactor.getPlaceById(id, languageUser);
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
    _route.goAudioGuide();
    closeMenuTab();
  }

  Future<bool> offMenuBack() async {
    bool? shouldPop = true;

    if (status.openMenu || status.openMenuTab) {
      status = status.copyWith(
          openMenu: false, openMenuTab: false, currentOption: -1);
      return !shouldPop;
    } else {
      IdtRoute.route = HomePage.namePage;
      return shouldPop;
    }
  }
}
