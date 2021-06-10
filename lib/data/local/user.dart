
import 'package:hive/hive.dart';
part  'user.g.dart';


@HiveType(typeId: 0)
class CurrentUser{
  CurrentUser({ this.id_user, this.id_db});
  @HiveField(0)
  int? id_user;
  @HiveField(1)
  int? id_db;

  @override
  String toString() {
    return '$id_db: $id_db';
  }
}


@HiveType(typeId: 1)
class Person {
  Person({  this.name, this.id, this.country, this.apellido, this.audioguias, this.audios});

  @HiveField(0)
  String? name;
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? country;
  @HiveField(3)
  String? apellido;
  @HiveField(4)
  List<Map>? audioguias;
  @HiveField(5)
  Map? audios;

  @override
  String toString() {
    return '$id';
  }
}