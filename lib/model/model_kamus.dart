// To parse this JSON data, do
//
//     final modelBerita = modelBeritaFromJson(jsonString);

import 'dart:convert';

ModelBerita modelBeritaFromJson(String str) =>
    ModelBerita.fromJson(json.decode(str));

String modelBeritaToJson(ModelBerita data) => json.encode(data.toJson());

class ModelBerita {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelBerita({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelBerita.fromJson(Map<String, dynamic> json) => ModelBerita(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String kosakata;
  String deskripsi;

  Datum({
    required this.id,
    required this.kosakata,
    required this.deskripsi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        kosakata: json["kosakata"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kosakata": kosakata,
        "deskripsi": deskripsi,
      };
}
