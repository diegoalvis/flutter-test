import 'package:bogota_app/view_model.dart';

class ProfileStatus extends ViewStatus{

  final String titleBar;
  final bool isLoading;
  final bool openMenu;

  ProfileStatus({required this.titleBar, required this.isLoading, required this.openMenu});

  ProfileStatus copyWith({String? titleBar, bool? isLoading, bool? openMenu }) {
    return ProfileStatus(
      titleBar: titleBar ?? this.titleBar,
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu
    );
  }
}
