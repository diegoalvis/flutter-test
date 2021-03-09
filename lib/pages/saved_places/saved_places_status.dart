import 'package:bogota_app/view_model.dart';

class SavedPlacesStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final List<bool> listSwitch;

  SavedPlacesStatus({required this.isLoading, required this.openMenu, required this.listSwitch});

  SavedPlacesStatus copyWith({bool? isLoading, bool? openMenu, List<bool>? listSwitch}) {
    return SavedPlacesStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      listSwitch: listSwitch ?? this.listSwitch
    );
  }
}
