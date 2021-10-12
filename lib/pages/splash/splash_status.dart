import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/view_model.dart';

class SplashStatus extends ViewStatus {
  late String? imgSplash;
  late String? logo ;
  final String? title;

  SplashStatus({this.logo, this.title, this.imgSplash});

  SplashStatus copyWith({
    String? imgSplash,
    String? logo,
    String? title,
  }) {
    return SplashStatus(
      imgSplash: imgSplash ?? this.imgSplash,
      logo: logo ?? this.logo,
      title: title ?? this.title,
    );
  }
}
