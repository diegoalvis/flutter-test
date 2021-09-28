import 'package:bogota_app/data/model/request/user_data_request.dart';
import 'package:bogota_app/data/model/response/user_update_response.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/pages/register_user/register_user_view_model.dart';
import 'package:bogota_app/view_model.dart';

class ProfileEditStatus extends ViewStatus {
  final String titleBar;
  final bool isLoading;
  final bool openMenu;
  final UserModel? currentUser;

  ProfileEditStatus(
      {required this.titleBar,
      required this.currentUser,
      required this.isLoading,
      required this.openMenu});

  ProfileEditStatus copyWith(
      {String? titleBar,
      bool? isLoading,
      bool? openMenu,
        UserModel? currentUser}) {
    return ProfileEditStatus(
      titleBar: titleBar ?? this.titleBar,
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
