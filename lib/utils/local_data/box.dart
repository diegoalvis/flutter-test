import 'package:bogota_app/data/local/user.dart';
import 'package:hive/hive.dart';

class BoxDataSesion {
  static late Box<Person> box;
  static late Box<CurrentUser> boxCurrentUser;
  static late Box<RememberMe> boxRememberMe;

  static final BoxDataSesion _boxData = BoxDataSesion._internal();

  factory BoxDataSesion() {
    return _boxData;
  }

  BoxDataSesion._internal() {
    boxSession().then((value) => box = value);
    boxSessionCurr().then((value) => boxCurrentUser = value);
    boxSessionRem().then((value) => boxRememberMe = value);
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
  static Future<Box<CurrentUser>> boxSessionCurr() async {
    try {
      print("=== Cargando BOX === ");
      boxCurrentUser = await Hive.openBox('currentuserdbB');
      print("✅ Box cargado");
      print("=================== ");
    } catch (e) {
      print("=== ❌ Error leyendo BOX === ");
      print(e);
      print("========================= ");
    }
    return boxCurrentUser;
  }


  static Future<Box<RememberMe>> boxSessionRem() async {
    try {
      print("=== Cargando BOX === ");
      boxRememberMe = await Hive.openBox('rememberMedB');
      print("✅ Box rememberMedB cargado");
      print("=================== ");
    } catch (e) {
      print("=== ❌ Error leyendo BOX rememberMedB === ");
      print(e);
      print("========================= ");
    }
    return boxRememberMe;
  }

  static void pushToBox(dynamic value, int key) async {
    await box.put(key, value);
    print('✔ Se registra 0 con valor $value');
  }

  static Future<int> addToBox(dynamic value) async {

   var result= await box.add(value);
    print('✔ Se agrega usuario  valor $value');
    var filteredUsers = box.values
        .where((Person) => Person.id == value)
        .toList();

    print(filteredUsers.asMap());

    return result;
  }

  static Person? getFromBox(int index) {
    final Person? value = box.get(index);
    print('✔ Se recupera con 0 el valor $value');
    print(value);
    return value;
  }

  static Future<bool> existInBox(Person value) async {
    print("Person.id ${value}");
    bool exist= false;
    var filteredUsers = box.values
        .where((Person) => Person.id == value.id)
        .toList();
    print(filteredUsers.asMap());

    if (filteredUsers.length >0){
      return !exist;
    }
    else{
      return exist;
    }

  }
  static Future<int> getIndex(Person value) async{
    var allUsers = box.values.toList();
    print('allusers $allUsers');
    final index = allUsers.indexWhere((element) =>
    element.id == value.id);
    return index;
  }

/*  static Future<int> getListAudios(int index) async{

    final Person? person = await BoxDataSesion.getFromBox(index);

    var person = getFromBox(index);
    var allUsers = box.values.toList();
    print('allusers $allUsers');
    final index = allUsers.indexWhere((element) =>
    element.id == value.id);
    return index;
  }*/


  static bool get isLoggedIn {
    late bool value;
    late var data=null;
    try {
      data = getCurrentUser();
      print("data $data");
      if(data != null || data != ''){
        value= true;
      }
    }catch(e){
      print("catch $data");
      value = false;
    };
    print("value $value");
    return value;
  }

  static void clearBox() {
    box.clear();
    box.deleteFromDisk();
    print("=== 🧹Box limpiada === ");
  }
//*********Para el usuario actual***************

  static void pushToBoxCurrentU(CurrentUser value) async {

    await boxCurrentUser.put(0, value);
    print('✔ Se registra current user con valor ${value}');
    print('✔ Se registra current user con valor de usuario ${value.id_user}');
    print('✔ Se registra current user con valor de usuario ${value.id_db}');
  }

  static CurrentUser? getCurrentUser() {
    final CurrentUser? value = boxCurrentUser.get(0);
    print('devuelve usuario actual ${value!.id_user}');
    return value;
  }
  static void clearBoxCurrentUser() {
    boxCurrentUser.delete(0);
    //boxCurrentUser.deleteFromDisk();
    print("=== 🧹Box Current USer limpiada === ");
  }

  //********************Para recordar Usuario**********************//
  static Future<int> addToRememberBox(dynamic value) async {

    var result= await boxRememberMe.add(value);
    print('✔ Se agrega usuario  valor $value');
    return result;
  }

  static RememberMe? getFromRememberBox(int index) {
    final RememberMe? value = boxRememberMe.get(index);
    print('✔ Se recupera con 0 el valor $value');
    print(value);
    return value;
  }

  static  pushToRememberBox(dynamic value, int index) async {
    await boxRememberMe.putAt(index, value);
    print('✔ Se registra 0 con valor $value');
    return value;
  }

  static void   clearBoxRememberMe() {
    boxRememberMe.deleteAll(boxRememberMe.keys);
    //boxCurrentUser.deleteFromDisk();
    print("=== 🧹Box Remember me limpiada === ");
  }
}