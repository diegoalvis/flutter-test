import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/view_model.dart';

class UnmissableStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  late List<DataPlacesModel> itemsUnmissablePlaces;

  UnmissableStatus({required this.isLoading, required this.openMenu,required this.itemsUnmissablePlaces});

  UnmissableStatus copyWith({bool? isLoading, bool? openMenu,List<DataPlacesModel>? itemsUnmissablePlaces}) {
    return UnmissableStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      itemsUnmissablePlaces: itemsUnmissablePlaces ?? this.itemsUnmissablePlaces,
    );
  }
}
