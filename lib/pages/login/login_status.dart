import 'package:bogota_app/view_model.dart';

class LoginStatus extends ViewStatus{

  final bool isLoading;
  final bool moreText;
  final bool isFavorite;

  LoginStatus({required this.isLoading, required this.moreText, required this.isFavorite});

  LoginStatus copyWith({bool? isLoading, bool? moreText, bool? isFavorite}) {
    return LoginStatus(
        isLoading: isLoading ?? this.isLoading,
        moreText: moreText ?? this.moreText,
        isFavorite: isFavorite ?? this.isFavorite
    );
  }
}
