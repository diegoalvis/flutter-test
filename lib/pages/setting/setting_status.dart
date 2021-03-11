import 'package:bogota_app/view_model.dart';

class SettingStatus extends ViewStatus{

  final String titleBar;
  final bool isLoading;
  final bool openMenu;
  final bool switchNotification;
  final bool switchNotification2;

  SettingStatus({required this.titleBar, required this.isLoading, required this.openMenu,
    required this.switchNotification, required this.switchNotification2});

  SettingStatus copyWith({String? titleBar, bool? isLoading, bool? openMenu, bool? switchNotification,
    bool? switchNotification2}) {
    return SettingStatus(
        titleBar: titleBar ?? this.titleBar,
        isLoading: isLoading ?? this.isLoading,
        openMenu: openMenu ?? this.openMenu,
        switchNotification: switchNotification ?? this.switchNotification,
        switchNotification2: switchNotification2 ?? this.switchNotification2,
    );
  }
}
