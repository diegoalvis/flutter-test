import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/filters/filters_status.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FiltersViewModel extends ViewModel<FiltersStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  FiltersViewModel(this._route, this._interactor) {
    status = FiltersStatus(
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
      staggedList: []
    );
  }

  void onInit(String section, List<DataModel> categories, List<DataModel> subcategories,
      List<DataModel> zones, List<DataModel> places, DataModel item) {

    status = status.copyWith(isLoading: true);
    switch(section) {
      case 'category': {
        status = status.copyWith(itemsFilter: categories, type: 'Plan');
      } break;

      case 'subcategory': {
        status = status.copyWith(itemsFilter: subcategories, type: 'Producto');
      }break;

      case 'zone': {
        status = status.copyWith(itemsFilter: zones, type: 'Zona');
      }break;

      default: {
        status = status.copyWith(itemsFilter: []);
      }break;
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

    int count = 0;
    final List<StaggeredTile> listStaggered = places.asMap().entries.map((entry) {
      int rows = 3;
      count++;

      if(count > 2 && count < 6){
        rows = 2;
      }else if(count > 5 && count < 7){
        rows = 6;
      }else if(count > 6){
        rows = 3;
        count = 1;
      }
      return StaggeredTile.count(rows, 2);
    }).toList();

    status = status.copyWith(filterSubcategory: filtersSubcategory, filterCategory: filtersCategory,
        filterZone: filtersZone, placesFilter: places, isLoading: false, section: item.title, staggedList: listStaggered);

    //getFoodResponse();
  }

  void getFoodResponse() async {
    /*final foodResponse = await _interactor.getFoodPlacesList();

    if (foodResponse is IdtSuccess<List<DataModel>?>) {
      status = status.copyWith(itemsFoodPlaces: foodResponse.body!); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = foodResponse as IdtFailure<FoodError>;
      print(erroRes.message);
      UnimplementedError();
      // FoodError();
      //Todo implementar errores
    }*/
    status = status.copyWith(isLoading: false);
  }

  void onpenMenu() {
    if (status.openMenu==false){
      status = status.copyWith (openMenu: true, openMenuTab: false, openMenuFilter: false);
    }
    else{
      status = status.copyWith(openMenu: false);
    }
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onpenMenuTab() {
    final bool tapClick = status.openMenuTab;
    status = status.copyWith(openMenuTab: !tapClick, openMenu: false, openMenuFilter: false);
  }

  void closeMenuTab() {
    status = status.copyWith(openMenuTab: false);
  }

  void onpenMenuFilter() {
    final bool tapClick = status.openMenuFilter;
    status = status.copyWith(openMenuFilter: !tapClick, openMenu: false, openMenuTab: false);
  }

  void closeMenuFilter() {
    status = status.copyWith(openMenuFilter: false);
  }

  void getDataFilterAll(DataModel item, String section) async {

    status = status.copyWith(isLoading: true);
    final Map query = {
      section : item.id
    };

    final response = await _interactor.getPlacesList(query);

    if (response is IdtSuccess<List<DataModel>?>) {
      final places = response.body!;
      status = status.copyWith(placesFilter: places, section: item.title);

    } else {
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
    closeMenuTab();
    status = status.copyWith(isLoading: false);
  }

  void getDataFilter() async {
    status = status.copyWith(isLoading: true);

    final List<String> codesCategory = [];
    final List<String> codesSubategory = [];
    final List<String> codesZones = [];

    final Map query = {};
    String listQuery = '';
    status.filterCategory.forEach((element) {

      if(element != null){
        listQuery.isEmpty ? listQuery = element.id : listQuery += ','+element.id ;
        codesCategory.add(element.id);
      }
    });

    if(listQuery.isNotEmpty) {
      query['category'] = listQuery;
      listQuery = '';
    }

    status.filterSubcategory.forEach((element) {
      if(element != null){
        listQuery.isEmpty ? listQuery = element.id : listQuery += ','+element.id ;
        codesSubategory.add(element.id);
      }
    });

    if(listQuery.isNotEmpty) {
      query['subcategory'] = listQuery;
      listQuery = '';
    }

    status.filterZone.forEach((element) {
      if(element != null){
        listQuery.isEmpty ? listQuery = element.id : listQuery += ','+element.id ;
        codesZones.add(element.id);
      }
    });

    if(listQuery.isNotEmpty) {
      query['zone'] = listQuery;
      listQuery = '';
    }

    final response = await _interactor.getPlacesList(query);

    if (response is IdtSuccess<List<DataModel>?>) {
      print('Places: ${response.body!.length}');
      if(response.body!.length > 0){
        status = status.copyWith(placesFilter: response.body!);
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

    if(id == 1){
      List<DataModel?> filter = List.of(status.filterSubcategory);
      filter[index] = filter[index] != null ? null : items[index];
      status = status.copyWith(filterSubcategory: filter);
    }
    else if(id == 2){
      List<DataModel?> filter = List.of(status.filterZone);
      filter[index] = filter[index] != null ? null : items[index];
      status = status.copyWith(filterZone: filter);
    }
    else if(id == 3){
      List<DataModel?> filter = List.of(status.filterCategory);
      filter[index] = filter[index] != null ? null : items[index];
      status = status.copyWith(filterCategory: filter);
    }
  }

  void goDetailPage() {
   // _route.goDetail(isHotel: false, id: '278');
  }
}
