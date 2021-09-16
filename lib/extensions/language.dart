import 'package:bogota_app/data/model/language_model.dart';
import 'package:flag/flag.dart';
// import 'package:flag/flag.dart';

extension Language on LanguageModel {
  FlagsCode toFlagCode() {
    switch (this.prefix) {
      case 'es':
        return FlagsCode.CO;
        break;
      case 'en':
        return FlagsCode.US;
        break;
      case 'pt':
        return FlagsCode.BR;
        break;
      default:
        return FlagsCode.AD;
    }
  }
}
