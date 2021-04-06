import 'dart:convert';

import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/enviroment.dart';

enum AuthState { Reading, Validating, Error, Success }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.Reading);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UsuarioDb usuario;
  FlutterSecureStorage tokenStorage = FlutterSecureStorage();

  AuthState get currentState => state;
  UsuarioDb get user => usuario;

  Future login() async {
    // this.currentState = LoginStatus.Loading;
    emit(AuthState.Validating);

    final Map<String, String> data = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim()
    };

    final url = Uri.parse('${Environment.apiUrl}/login');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final loginResponse = userFromJson(resp.body);
      guardarToken(loginResponse.token);
      this.usuario = loginResponse.usuarioDb;

      emit(AuthState.Success);
    } else {
      emit(AuthState.Error);
    }
  }

  //Obtener token
  Future<String> getToken() async {
    final _store = new FlutterSecureStorage();
    final token = await _store.read(key: 'token');
    return token;
  }

  //Guardar token
  Future guardarToken(String token) async {
    return await tokenStorage.write(key: 'token', value: token);
  }

  //Quitar token
  Future quitarToken() async {
    return await tokenStorage.delete(key: 'token');
  }
}
