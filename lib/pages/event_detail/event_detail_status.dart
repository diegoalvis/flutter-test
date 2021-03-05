import 'package:bogota_app/view_model.dart';

class EventDetailStatus extends ViewStatus{

  final bool isLoading;
  final bool moreText;
  final bool openMenuTab;

  EventDetailStatus({this.isLoading, this.moreText, this.openMenuTab});

  EventDetailStatus copyWith({bool isLoading, bool moreText, bool openMenuTab }) {
    return EventDetailStatus(
      isLoading: isLoading ?? this.isLoading,
      moreText: moreText ?? this.moreText,
      openMenuTab: openMenuTab ?? this.openMenuTab
    );
  }
}
