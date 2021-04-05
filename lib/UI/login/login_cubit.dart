import 'dart:convert';

import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/enviroment.dart';

enum LoginStatus { Reading, Loading, Error, Success }

class LoginCubit extends Cubit<LoginStatus> {
  LoginCubit() : super(null);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UsuarioDb usuario;

  void returnToReadingState() {
    emit(LoginStatus.Reading);
  }

  Future login() async {
    final Map<String, String> data = {
      'email': emailController.text,
      'password': passwordController.text
    };

    final url = Uri.parse('${Environment.apiUrl}/login');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      print(resp.body);
      final loginResponse = userFromJson(resp.body);
      this.usuario = loginResponse.usuarioDb;
      emit(LoginStatus.Success);
    } else {
      emit(LoginStatus.Error);
    }
  }
}
