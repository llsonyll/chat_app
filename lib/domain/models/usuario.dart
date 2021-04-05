import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.ok,
    this.usuarioDb,
    this.token,
  });

  bool ok;
  UsuarioDb usuarioDb;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        ok: json["ok"],
        usuarioDb: UsuarioDb.fromJson(json["usuarioDB"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarioDB": usuarioDb.toJson(),
        "token": token,
      };
}

class UsuarioDb {
  UsuarioDb({
    this.online,
    this.nombre,
    this.email,
    this.uid,
  });

  bool online;
  String nombre;
  String email;
  String uid;

  factory UsuarioDb.fromJson(Map<String, dynamic> json) => UsuarioDb(
        online: json["online"],
        nombre: json["nombre"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "nombre": nombre,
        "email": email,
        "uid": uid,
      };
}
