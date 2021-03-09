import 'package:bogota_app/view_model.dart';

class UnmissableStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;

  UnmissableStatus({required this.isLoading, required this.openMenu});

  UnmissableStatus copyWith({bool? isLoading, bool? openMenu}) {
    return UnmissableStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu
    );
  }
}
