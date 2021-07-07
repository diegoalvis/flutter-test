import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
part 'user.g.dart';

@HiveType(typeId: 0)
class RememberMe {
  RememberMe(
      {required this.email, required this.password, required this.state});
  @HiveField(0)
  String email;
  @HiveField(1)
  String password;
  @HiveField(2)
  bool state;

  @override
  String toString() {
    return '$email: $password';
  }
}

@HiveType(typeId: 1)
class CurrentUser {
  CurrentUser({this.id_user, this.id_db});
  @HiveField(0)
  int? id_user;
  @HiveField(1)
  int? id_db;

  @override
  String toString() {
    return '$id_db: $id_db';
  }
}

@HiveType(typeId: 2)
class Person {
  Person(
      {this.name,
      this.id,
      this.country,
      this.apellido,
      this.audioguias,
      this.audios,
      this.detalle});

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
  @HiveField(6)
  List<DataAudioGuideModel>? detalle;

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        country: json["country"] == null ? null : json["country"],
        apellido: json["apellido"] == null ? null : json["apellido"],
        audioguias: json["audioguias"] == null ? null : json["audioguias"],
        audios: json["audios"] == null ? null : json["audios"],
        detalle: json["detalle"] == null
            ? null
            : List<DataAudioGuideModel>.from(
                json["detalle"].map((x) => DataAudioGuideModel.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
        "country": country == null ? null : country,
        "apellido": apellido == null ? null : apellido,
        "audioguias": audioguias == null ? null : audioguias,
        "audios": audios == null ? null : audios,
        "detalle": detalle == null
            ? null
            : List<dynamic>.from(detalle!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return '$id';
  }
}
