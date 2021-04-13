// To parse this JSON data, do
//
//     final mensajes = mensajesFromJson(jsonString);

import 'dart:convert';

Mensajes mensajesFromJson(String str) => Mensajes.fromJson(json.decode(str));

String mensajesToJson(Mensajes data) => json.encode(data.toJson());

class Mensajes {
  Mensajes({
    this.ok,
    this.miId,
    this.mensajesDe,
    this.mensajes,
  });

  bool ok;
  String miId;
  String mensajesDe;
  List<ChatMessage> mensajes;

  factory Mensajes.fromJson(Map<String, dynamic> json) => Mensajes(
        ok: json["ok"],
        miId: json["miId"],
        mensajesDe: json["mensajesDe"],
        mensajes: List<ChatMessage>.from(
            json["mensajes"].map((x) => ChatMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "miId": miId,
        "mensajesDe": mensajesDe,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class ChatMessage {
  ChatMessage({
    this.de,
    this.para,
    this.mensaje,
    this.createdAt,
    this.updatedAt,
  });

  String de;
  String para;
  String mensaje;
  DateTime createdAt;
  DateTime updatedAt;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
