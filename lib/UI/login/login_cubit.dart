import 'dart:convert';

import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/enviroment.dart';

enum LoginStatus { Reading, Validating, Error, Success }

class LoginCubit extends Cubit<LoginStatus> {
  LoginCubit() : super(LoginStatus.Reading);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UsuarioDb usuario;

  LoginStatus get currentState => state;
  UsuarioDb get user => usuario;

  Future login() async {
    // this.currentState = LoginStatus.Loading;
    emit(LoginStatus.Validating);

    final Map<String, String> data = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim()
    };

    final url = Uri.parse('${Environment.apiUrl}/login');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final loginResponse = userFromJson(resp.body);
      this.usuario = loginResponse.usuarioDb;
      emit(LoginStatus.Success);
    } else {
      emit(LoginStatus.Error);
    }
  }
}
