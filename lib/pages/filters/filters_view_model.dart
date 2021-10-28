import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/pages/discover/discover_page.dart';
import 'package:bogota_app/pages/filters/filters_status.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:location/location.dart';

import 'filter_effect.dart';

class FiltersViewModel extends EffectsViewModel<FiltersStatus, FilterEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  Location locationUser = Location();
  String latitud = '';
  String longitud = '';
  late String languageUser;


  FiltersViewModel(this._route, this._interactor) {
    status = FiltersStatus(
        switchCloseToMe: false,
        isLoading: false,
        openMenu: false,
        openMenuTab: false,
        openMenuFilter: false,
        filterSubcategory: [],
        filterZone: [],
        filterCategory: [],
        itemsFilter: [],
        placesFilter: [],
        section: '',
        type: '',
        oldFilters: {},
        staggedList: []);
  }

  void onInit(String section, List<DataModel> categories, List<DataModel> subcategories,
      List<DataModel> zones, List<DataModel> places, DataModel item, Map oldFilters) {

    status = status.copyWith(isLoading: true);
    switch (section) {
      case 'category':
        {
          status = status.copyWith(itemsFilter: categories, type: 'Plan');
        }
        break;

      case 'subcategory':
        {
          status = status.copyWith(itemsFilter: subcategories, type: 'Producto');
        }
        break;

      case 'zone':
        {
          status = status.copyWith(itemsFilter: zones, type: 'Zona');
        }
        break;

      default:
        {
          status = status.copyWith(itemsFilter: []);
        }
        break;
    }

    final List<DataModel?> filtersCategory = categories.map((element) {
      return null;
    }).toList();

    final List<DataModel?> filtersSubcategory = subcategories.map((element) {
      return null;
    }).toList();

    final List<DataModel?> filtersZone = zones.map((element) {
      return null;
    }).toList();

    if (places.length < 1) {
      addEffect(ShowDialogEffect());
    }

    //Recargando Diseño
    List<StaggeredTile> listDesing = redesignGridFilter(places);

    status = status.copyWith(
        filterSubcategory: filtersSubcategory,
        filterCategory: filtersCategory,
        filterZone: filtersZone,
        placesFilter: places,
        isLoading: false,
        section: item.title,
        staggedList: listDesing,
        oldFilters: oldFilters
        );

    //getFoodResponse();
  }

  void openMenu() {
      status = status.copyWith(openMenu: !status.openMenu, openMenuTab: false, openMenuFilter: false);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void openMenuTab() {
    status = status.copyWith(openMenuTab: !status.openMenuTab, openMenu: false, openMenuFilter: false);
  }

  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false);
  }

  void openMenuFilter() {
    final bool tapClick = status.openMenuFilter;
    status = status.copyWith(openMenuFilter: !tapClick, openMenu: false, openMenuTab: false);
  }

  void closeMenuFilter() {
    status = status.copyWith(openMenuFilter: false);
  }


  void getDataFilterAll(DataModel item, String section) async {
    //Hacer validacion cuando se seleccione la misma opcion

    status = status.copyWith(isLoading: true);
    Map<String,dynamic> query = {section: item.id};
    languageUser = BoxDataSesion.getLaguageByUser();
    //get language User Prefered

    if (section == 'subcategory') {
      final itemsSubCat =
      await _interactor.getPlacesSubcategory(item.id, languageUser);

      if (itemsSubCat is IdtSuccess<List<DataModel>?>) {
        final listIds = itemsSubCat.body!.map((e) => e.id).toList().join(",");
        query = {section: listIds};
      }
    } else {
      query = {section: item.id};
    }
    print(query);
    //Asta aqui todo bien

    final response = await _interactor.getPlacesList( query, status.oldFilters!,languageUser);

    if (response is IdtSuccess<List<DataModel>?>) {
      final places = response.body!;
      List<StaggeredTile> listDesing = redesignGridFilter(response.body);
      status = status.copyWith(
        placesFilter: places,
        section: item.title,
        staggedList: listDesing,
        oldFilters: query,
      );
    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);

      UnimplementedError();
    }
    closeMenuTab();
    status = status.copyWith(isLoading: false, );
  }

  void getDataFilter() async {
    languageUser = BoxDataSesion.getLaguageByUser();
    status = status.copyWith(isLoading: true);

    final List<String> codesCategory = [];
    final List<String> codesSubategory = [];
    final List<String> codesZones = [];

    final Map<String,dynamic> query = {};
    String listQuery = '';
    status.filterCategory.forEach((element) {
      if (element != null) {
        listQuery.isEmpty ? listQuery = element.id : listQuery += ',' + element.id;
        codesCategory.add(element.id);
      }
    });

    if (listQuery.isNotEmpty) {
      query['category'] = listQuery;
      listQuery = '';
    }
    //TODO sedebe primero consultar el value.
    status.filterSubcategory.forEach((element) {
      if (element != null) {
        listQuery.isEmpty ? listQuery = element.id : listQuery += ',' + element.id;
        // if (element == 'subcategory') {
        //   final itemsSubCat =
        //       await _interactor.getPlacesSubcategory(item.id, languageUser);
        //
        //   if (itemsSubCat is IdtSuccess<List<DataModel>?>) {
        //     final listIds = itemsSubCat.body!.map((e) => e.id).toList().join(",");
        //     query = {section: listIds};
        //   }
        // } else {
        //   query = {section: item.id};
        // }
        // print(query);
        //Asta aqui todo bien
        // final response = await _interactor.getPlacesList( query, status.oldFilters!,languageUser);


        codesSubategory.add(element.id);
      }
    });

    if (listQuery.isNotEmpty) {
      query['subcategory'] = listQuery;
      listQuery = '';
    }

    status.filterZone.forEach((element) {
      if (element != null) {
        listQuery.isEmpty ? listQuery = element.id : listQuery += ',' + element.id;
        codesZones.add(element.id);
      }
    });

    if (listQuery.isNotEmpty) {
      query['zone'] = listQuery;
      listQuery = '';
    }
    final response = await _interactor.getPlacesList(query, status.oldFilters!, languageUser);

    if (response is IdtSuccess<List<DataModel>?>) {
      print('Places: ${response.body!.length}');
      if (response.body!.length > 0) {
        List<StaggeredTile> listDesing = redesignGridFilter(response.body);
        status = status.copyWith(placesFilter: response.body!,staggedList: listDesing);
      }else{
        addEffect(ShowDialogEffect());
        status = status.copyWith(placesFilter: [],);

      }
      // TODO: Mostrar mensaje que no hay resultados

    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    closeMenuFilter();
    status = status.copyWith(isLoading: false);
  }

  void onTapButton(int index, int id, List<DataModel> items) {
    if (id == 1) {
      List<DataModel?> filter = List.of(status.filterSubcategory);
      filter[index] = filter[index] != null ? null : items[index];
      status = status.copyWith(filterSubcategory: filter);
    } else if (id == 2) {
      List<DataModel?> filter = List.of(status.filterZone);
      filter[index] = filter[index] != null ? null : items[index];
      status = status.copyWith(filterZone: filter);
    } else if (id == 3) {
      List<DataModel?> filter = List.of(status.filterCategory);
      filter[index] = filter[index] != null ? null : items[index];
      status = status.copyWith(filterCategory: filter);
    }
  }

  void onTapResetSearch() {
    List<DataModel?> filter = List.of(status.filterSubcategory);
    for (var i = 0; i < filter.length; i++) {
      filter[i] = null;
    }
    status = status.copyWith(filterSubcategory: filter);

    filter = List.of(status.filterZone);
    for (var i = 0; i < filter.length; i++) {
      filter[i] = null;
    }
    status = status.copyWith(filterZone: filter);

    filter = List.of(status.filterCategory);
    for (var i = 0; i < filter.length; i++) {
      filter[i] = null;
    }
    status = status.copyWith(filterCategory: filter);
  }


  goDetailPage(String id) async{
    status = status.copyWith(isLoading: true);
    languageUser = BoxDataSesion.getLaguageByUser();
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
      final erroRes = placebyidResponse as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  getLoc() async {
    LocationData _currentPosition;
    _currentPosition = await locationUser.getLocation();

    print(_currentPosition);
    longitud = _currentPosition.longitude.toString();
    print(longitud);
    latitud = _currentPosition.latitude.toString();
    print(latitud);
    // fecha = _currentPosition.time.toString();
  }

  getPlacesCloseToMe(bool isSwitch) async{
    status = status.copyWith(isLoading: true, switchCloseToMe: isSwitch);
    languageUser = BoxDataSesion.getLaguageByUser();
    await getLoc();
    final response = await _interactor.getPlacesCloseToMe('$latitud,$longitud',languageUser );


    if (response is IdtSuccess<List<DataModel>?>) {

      final places = response.body!;

      List<StaggeredTile> listDesing = redesignGridFilter(places);

      status = status.copyWith(placesFilter: places,staggedList: listDesing);
      // _route.goDetail(isHotel: false, detail: placesClosedToMe.body!);

      /// Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  Future<bool> offMenuBack()async {
    bool? shouldPop = true;

    if (status.openMenu || status.openMenuFilter || status.openMenuTab) {
      status = status.copyWith(openMenu: false, openMenuTab: false, openMenuFilter: false);
      return !shouldPop;
    } else {
      IdtRoute.route = DiscoverPage.namePage;
      return shouldPop;
    }
  }

  List<StaggeredTile> redesignGridFilter(List<DataModel>? places){
    int count = 0;

    final List<StaggeredTile> listStaggered = places!.asMap().entries.map((entry) {
      int rows = 3;
      count++;

      if (count > 2 && count < 6) {
        rows = 2;
      } else if (count > 5 && count < 7) {
        rows = 6;
      } else if (count > 6) {
        rows = 3;
        count = 1;
      }
      return StaggeredTile.count(rows, 2);
    }).toList();

    return listStaggered;
  }
}
