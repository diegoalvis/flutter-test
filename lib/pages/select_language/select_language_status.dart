import 'package:bogota_app/data/model/language_model.dart';
import 'package:bogota_app/view_model.dart';

class SelectLanguageStatus extends ViewStatus {
  final bool isLoading;
  final List<LanguageModel> languagesAvalibles;
  final bool isButtonEnable;
  final int? indexSelect;

  // late UserModel? dataUser;

  SelectLanguageStatus(
      {required this.isLoading,
        required this.isButtonEnable,
        required this.languagesAvalibles,
        required this.indexSelect,
      });

  SelectLanguageStatus copyWith({
    bool? isLoading,
    bool? isButtonEnable,
    List<LanguageModel>? languagesAvalibles,
    int? indexSelect,

  }) {
    return SelectLanguageStatus(
      indexSelect:  indexSelect ?? this.indexSelect,
      isLoading: isLoading ?? this.isLoading,
      languagesAvalibles: languagesAvalibles ?? this.languagesAvalibles,
      isButtonEnable: isButtonEnable ?? this.isButtonEnable,
    );
  }
}
