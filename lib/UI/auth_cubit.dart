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
  final _storage = new FlutterSecureStorage();

  AuthState get currentState => state;
  UsuarioDb get user => usuario;

  // Login Method
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

  // Logout method
  Future logout() async {
    await _storage.delete(key: 'token');
  }

  // Obtener token
  Future<String> getToken() async {
    final token = await _storage.read(key: 'token');
    return token;
  }

  // Guardar token
  Future guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  // Quitar token
  Future borrarToken() async {
    return await _storage.delete(key: 'token');
  }

  // Validate Token > to Home or Login
  Future<bool> isTokenValid() async {
    final token = await this._storage.read(key: 'token');
    final url = Uri.parse('${Environment.apiUrl}/login/renew');
    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = userFromJson(resp.body);
      this.usuario = loginResponse.usuarioDb;
      await this.guardarToken(token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      print(respBody);
      this.logout();
      return false;
      // return respBody['msg'];
    }
  }
}
