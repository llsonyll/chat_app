import 'dart:convert';

// USUARIO JSON Model <<<<<<< MODELO DE BASE DE DATOS > SCHEMA   >>>>>>>
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

// Auth JSON Model <<<<<<< .../api/login/  >>>>>>>
AuthQuery authQueryFromJson(String str) => AuthQuery.fromJson(json.decode(str));
String aserToJson(AuthQuery data) => json.encode(data.toJson());

class AuthQuery {
  AuthQuery({
    this.ok,
    this.usuarioDb,
    this.token,
  });

  bool ok;
  UsuarioDb usuarioDb;
  String token;

  factory AuthQuery.fromJson(Map<String, dynamic> json) => AuthQuery(
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

// Lista Usuarios JSON Model <<<<<<< ..../api/usuarios || ?desde=3  >>>>>>>
ListaUsuarios listaUsuariosFromJson(String str) =>
    ListaUsuarios.fromJson(json.decode(str));
String listaUsuariosToJson(ListaUsuarios data) => json.encode(data.toJson());

class ListaUsuarios {
  ListaUsuarios({
    this.ok,
    this.usuarios,
  });

  bool ok;
  List<UsuarioDb> usuarios;

  factory ListaUsuarios.fromJson(Map<String, dynamic> json) => ListaUsuarios(
        ok: json["ok"],
        usuarios: List<UsuarioDb>.from(
            json["usuarios"].map((x) => UsuarioDb.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
      };
}
