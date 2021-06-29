import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class HomeStatus extends ViewStatus {
  final String titleBar;
  final bool isLoading;
  final bool openMenu;
  final bool openSaved;
  final bool notSaved;
  final bool seeAll;
  late List imagesMenu;
  late List<DataModel> itemsUnmissablePlaces;
  late List<DataModel> itemsEatPlaces;
  late List<DataModel> itemsbestRatedPlaces;
  late List<DataModel> itemsSavedPlaces;

  HomeStatus({required this.itemsEatPlaces, required this.itemsUnmissablePlaces, required this.itemsbestRatedPlaces,
    required this.itemsSavedPlaces, required this.imagesMenu,
    required this.titleBar, required this.isLoading, required this.openMenu, required this.openSaved,
    required this.notSaved, required this.seeAll});

  HomeStatus copyWith({String? titleBar, bool? isLoading, bool? openMenu, bool? openSaved, bool? notSaved,List? imagesMenu,
    bool? seeAll, List<DataModel>? itemsUnmissablePlaces,List<DataModel>? itemsEatPlaces, List<DataModel>?itemsbestRatedPlaces ,
  List<DataModel>? itemsSavedPlaces}) {
    return HomeStatus(
      titleBar: titleBar ?? this.titleBar,
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      openSaved: openSaved ?? this.openSaved,
      notSaved: notSaved ?? this.notSaved,
      seeAll: seeAll ?? this.seeAll,
      imagesMenu: imagesMenu ?? this.imagesMenu,
      itemsUnmissablePlaces: itemsUnmissablePlaces ?? this.itemsUnmissablePlaces,
      itemsEatPlaces: itemsEatPlaces ?? this.itemsEatPlaces,
      itemsbestRatedPlaces: itemsbestRatedPlaces ?? this.itemsbestRatedPlaces,
      itemsSavedPlaces: itemsSavedPlaces ??this.itemsSavedPlaces
    );
  }
}
