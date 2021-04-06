import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../enviroment.dart';

enum RegisterState {
  ReadingState,
  ValidatingState,
  SuccessState,
  ErrorState,
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState.ReadingState);

  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future register() async {
    emit(RegisterState.ValidatingState);

    final Map<String, String> data = {
      'nombre': nombreController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim()
    };

    final url = Uri.parse('${Environment.apiUrl}/login/new');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      print(resp.body);
      emit(RegisterState.SuccessState);
    } else {
      emit(RegisterState.ErrorState);
      print(resp.body);
    }
  }
}
