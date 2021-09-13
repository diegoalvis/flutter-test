import 'package:bogota_app/data/model/language_model.dart';
import 'package:bogota_app/view_model.dart';

class SelectLanguageStatus extends ViewStatus {
  final bool isLoading;
  late List<LanguageModel> languagesAvalibles;


  // late UserModel? dataUser;

  SelectLanguageStatus({
    required this.isLoading,
    required this.languagesAvalibles
  });

  SelectLanguageStatus copyWith({
    bool? isLoading,
    List<LanguageModel>? languagesAvalibles,
  }) {
    return SelectLanguageStatus(

      isLoading: isLoading ?? this.isLoading,
      languagesAvalibles: languagesAvalibles ?? this.languagesAvalibles,

    );
  }
}
