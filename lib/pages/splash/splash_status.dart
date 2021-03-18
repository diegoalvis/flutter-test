import 'package:bogota_app/view_model.dart';

class SplashStatus extends ViewStatus {
  final String imgSplash;

  SplashStatus({required this.imgSplash});

  SplashStatus copyWith({
    String? imgSplash,
  }) {
    return SplashStatus(
      imgSplash: imgSplash ?? this.imgSplash,
    );
  }
}
