import 'package:bogota_app/view_model.dart';

class HomeStatus extends ViewStatus{

  final String titleBar;
  final bool isLoading;
  final bool openMenu;

  HomeStatus({this.titleBar, this.isLoading, this.openMenu});

  HomeStatus copyWith({String titleBar, bool isLoading, bool openMenu }) {
    return HomeStatus(
      titleBar: titleBar ?? this.titleBar,
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu
    );
  }
}
