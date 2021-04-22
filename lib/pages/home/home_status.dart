import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class HomeStatus extends ViewStatus {
  final String titleBar;
  final bool isLoading;
  final bool openMenu;
  final bool openSaved;
  final bool notSaved;
  final bool seeAll;
  late List<DataModel> itemsUnmissablePlaces;
  late List<DataModel> itemsFoodPlaces;

  HomeStatus( {required this.itemsFoodPlaces, required this.itemsUnmissablePlaces,required this.titleBar, required this.isLoading, required this.openMenu, required this.openSaved,
    required this.notSaved, required this.seeAll});

  HomeStatus copyWith({String? titleBar, bool? isLoading, bool? openMenu, bool? openSaved, bool? notSaved,
    bool? seeAll, List<DataModel>? itemsUnmissablePlaces,List<DataModel>? itemsFoodPlaces }) {
    return HomeStatus(
      titleBar: titleBar ?? this.titleBar,
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openSaved: openSaved ?? this.openSaved,
      notSaved: notSaved ?? this.notSaved,
      seeAll: seeAll ?? this.seeAll,
      itemsUnmissablePlaces: itemsUnmissablePlaces ?? this.itemsUnmissablePlaces,
      itemsFoodPlaces: itemsFoodPlaces ?? this.itemsFoodPlaces
    );
  }
}
