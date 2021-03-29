import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<List<String>> {
  ChatCubit() : super([]);

  void init() {}
}

class InputCubit extends Cubit<String> {
  InputCubit() : super('');

  TextEditingController inputController = TextEditingController();

  void imprimirController() {
    print('Controller Value: ${inputController.text}');
    emit(inputController.text);
  }

  void enviarMensaje() {
    inputController.clear();
    emit(inputController.text);
  }
}
