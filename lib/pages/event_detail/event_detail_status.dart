import 'package:bogota_app/view_model.dart';

class EventDetailStatus extends ViewStatus{

  final bool isLoading;
  final bool moreText;
  final bool isFavorite;

  EventDetailStatus({required this.isLoading, required this.moreText, required this.isFavorite});

  EventDetailStatus copyWith({bool? isLoading, bool? moreText, bool? isFavorite}) {
    return EventDetailStatus(
      isLoading: isLoading ?? this.isLoading,
      moreText: moreText ?? this.moreText,
      isFavorite: isFavorite ?? this.isFavorite
    );
  }
}
