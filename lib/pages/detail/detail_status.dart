import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/view_model.dart';

class DetailStatus extends ViewStatus{

  final bool isLoading;
  final bool moreText;
  final bool isFavorite;


  DetailStatus({required this.isLoading, required this.moreText,
    required this.isFavorite});

  DetailStatus copyWith({bool? isLoading, bool? moreText,
    bool? isFavorite,}) {
    return DetailStatus(
      isLoading: isLoading ?? this.isLoading,
      moreText: moreText ?? this.moreText,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
