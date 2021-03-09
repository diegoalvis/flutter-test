import 'package:bogota_app/view_model.dart';

class SearchStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;

  SearchStatus({required this.isLoading, required this.openMenu});

  SearchStatus copyWith({bool? isLoading, bool? openMenu}) {
    return SearchStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu
    );
  }
}
