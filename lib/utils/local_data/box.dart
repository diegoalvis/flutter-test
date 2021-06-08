import 'package:bogota_app/data/local/user.dart';
import 'package:hive/hive.dart';

class BoxDataSesion {
  static late Box<Person> box;

  static final BoxDataSesion _boxData = BoxDataSesion._internal();

  factory BoxDataSesion() {
    return _boxData;
  }

  BoxDataSesion._internal() {
    boxSession().then((value) => box = value);
  }

  static Future<Box<Person>> boxSession() async {
    try {
      print("=== Cargando BOX === ");
      box = await Hive.openBox('userdbB');
      print("✅ Box cargado");
      print("=================== ");
    } catch (e) {
      print("=== ❌ Error leyendo BOX === ");
      print(e);
      print("========================= ");
    }
    return box;
  }

  static void pushToBox(dynamic value) async {
    await box.put(0, value);
    print('✔ Se registra 0 con valor $value');
  }

  static Person? getFromBox() {
    final Person? value = box.get(0);
    print('✔ Se recupera con 0 el valor $value');
    print(value);
    return value;
  }

  static bool get isLoggedIn {
    final Person? value = box.get(0);
    print('✔ Se verifica si logueado ${value != null}');
    return value != null;
  }

  static void clearBox() {
    box.clear();
    box.deleteFromDisk();
    print("=== 🧹Box limpiada === ");
  }
}
