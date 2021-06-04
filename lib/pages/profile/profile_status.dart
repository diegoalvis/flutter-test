import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/view_model.dart';

class ProfileStatus extends ViewStatus {
  final String titleBar;
  final bool isLoading;
  final bool openMenu;
  late UserModel? dataUser;

  ProfileStatus(
      {
      required this.dataUser,
      required this.titleBar,
      required this.isLoading,
      required this.openMenu});

  ProfileStatus copyWith(
      {
      String? titleBar,
      bool? isLoading,
      bool? openMenu,
      UserModel? dataUser}) {
    return ProfileStatus(
        titleBar: titleBar ?? this.titleBar,
        dataUser: dataUser ?? this.dataUser,
        isLoading: isLoading ?? this.isLoading,
        openMenu: openMenu ?? this.openMenu);
  }
}
