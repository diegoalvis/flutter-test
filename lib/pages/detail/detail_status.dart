import 'package:bogota_app/view_model.dart';

class DetailStatus extends ViewStatus{

  final bool isLoading;
  final bool moreText;
  final bool openMenuTab;

  DetailStatus({this.isLoading, this.moreText, this.openMenuTab});

  DetailStatus copyWith({bool isLoading, bool moreText, bool openMenuTab }) {
    return DetailStatus(
      isLoading: isLoading ?? this.isLoading,
      moreText: moreText ?? this.moreText,
      openMenuTab: openMenuTab ?? this.openMenuTab
    );
  }
}
