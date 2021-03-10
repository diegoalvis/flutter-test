import 'package:bogota_app/view_model.dart';

class ProfileEditStatus extends ViewStatus{

  final String titleBar;
  final bool isLoading;
  final bool openMenu;

  ProfileEditStatus({required this.titleBar, required this.isLoading, required this.openMenu});

  ProfileEditStatus copyWith({String? titleBar, bool? isLoading, bool? openMenu }) {
    return ProfileEditStatus(
      titleBar: titleBar ?? this.titleBar,
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu
    );
  }
}
