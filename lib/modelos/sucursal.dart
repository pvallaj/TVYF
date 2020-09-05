// To parse this JSON data, do
//
//     final sucursal = sucursalFromJson(jsonString);

import 'dart:convert';

Sucursal sucursalFromJson(String str) => Sucursal.fromJson(json.decode(str));

String sucursalToJson(Sucursal data) => json.encode(data.toJson());

class Sucursal {
  Sucursal({
    this.id,
    this.nombre,
    this.subtitulo,
    this.lat,
    this.lng,
  });

  String id;
  String nombre;
  String subtitulo;
  double lat;
  double lng;

  factory Sucursal.fromJson(Map<String, dynamic> json) => Sucursal(
        id: json["id"],
        nombre: json["nombre"],
        subtitulo: json["subtitulo"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "subtitulo": subtitulo,
        "lat": lat,
        "lng": lng,
      };
}
