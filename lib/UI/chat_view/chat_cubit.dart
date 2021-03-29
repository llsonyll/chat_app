import 'package:chat_app/domain/models/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<List<ChatMessage>> {
  ChatCubit() : super([]);

  void init() {
    state.add(ChatMessage(uid: '123', mensaje: 'Mensaje 1'));
    state.add(ChatMessage(uid: '1', mensaje: 'Mensaje 2'));
    state.add(ChatMessage(uid: '123', mensaje: 'Mensaje 3'));
    state.add(ChatMessage(uid: '1', mensaje: 'Mensaje 4'));

    emit(List<ChatMessage>.from(state));
  }

  void addMessage(String message) {
    state.add(ChatMessage(uid: '123', mensaje: message));
    emit(List<ChatMessage>.from(state));
  }
}

class InputCubit extends Cubit<String> {
  InputCubit() : super('');

  TextEditingController inputController = TextEditingController();

  void leerMensaje() {
    print('Controller Value: ${inputController.text}');
    emit(inputController.text);
  }

  void enviarMensaje() {
    inputController.clear();
    emit(inputController.text);
  }
}
