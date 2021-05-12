
import 'package:hive/hive.dart';
part  'user.g.dart';

@HiveType(typeId: 1)
class Person {
  Person({  this.name, this.id, this.country, this.apellido, this.audioguias});

  @HiveField(0)
  String? name;
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? country;
  @HiveField(3)
  String? apellido;
  @HiveField(4)
  List<String>? audioguias;

  @override
  String toString() {
    return '$name: $id';
  }
}