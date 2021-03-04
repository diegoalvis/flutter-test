import 'package:bogota_app/view_model.dart';

class ResultSearchStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;

  ResultSearchStatus({this.isLoading, this.openMenu});

  ResultSearchStatus copyWith({bool isLoading, bool openMenu}) {
    return ResultSearchStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu
    );
  }
}
