import 'package:bogota_app/data/model/language_model.dart';
import 'package:flag/flag.dart';
// import 'package:flag/flag.dart';

extension Language on LanguageModel {
  FlagsCode toFlagCode() {
    switch (this.prefix) {
      case 'es':
        return FlagsCode.CO;
        break;
      default:

        return FlagsCode.AD;
    }
  }
}
