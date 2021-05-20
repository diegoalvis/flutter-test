import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/view_model.dart';

class SearchStatus extends ViewStatus {
  final bool isLoading;
  final bool openMenu;
  final List<DataModel>? itemsResultSearch;

  SearchStatus({required this.isLoading, required this.openMenu, required this.itemsResultSearch});

  SearchStatus copyWith({bool? isLoading, bool? openMenu, List<DataModel>? itemsResultSearch}) {
    return SearchStatus(
        isLoading: isLoading ?? this.isLoading,
        openMenu: openMenu ?? this.openMenu,
        itemsResultSearch: itemsResultSearch ?? this.itemsResultSearch
    );
  }
}
