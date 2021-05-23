import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class UnmissableStatus extends ViewStatus {
  final int currentOption;
  final bool isLoading;
  final bool openMenu;
  late List<DataModel> itemsUnmissablePlaces;
  late List<DataModel> itemsbestRatedPlaces;

  UnmissableStatus(
      {required this.currentOption,
      required this.isLoading,
      required this.openMenu,
      required this.itemsUnmissablePlaces,
      required this.itemsbestRatedPlaces});

  UnmissableStatus copyWith(
      {int? currentOption,
      bool? isLoading,
      bool? openMenu,
      List<DataModel>? itemsUnmissablePlaces,
      List<DataModel>? itemsbestRatedPlaces}) {
    return UnmissableStatus(
        currentOption: currentOption ?? this.currentOption,
        isLoading: isLoading ?? this.isLoading,
        openMenu: openMenu ?? this.openMenu,
        itemsUnmissablePlaces: itemsUnmissablePlaces ?? this.itemsUnmissablePlaces,
        itemsbestRatedPlaces: itemsbestRatedPlaces ?? this.itemsbestRatedPlaces);
  }
}
