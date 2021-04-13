import 'package:chat_app/UI/socket_io_cubit.dart';
import 'package:chat_app/domain/models/chat_message.dart';
import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<List<ChatMessage>> {
  ChatCubit() : super([]);
  // ChatServiceCubit chatServiceCubit;

  void init(BuildContext context) {
    final socketService = context.read<SocketService>();
    socketService.socket.on('mensaje-personal', escucharMensaje);

    // Listar mensajes desde la base de datos...

    // emit(List<ChatMessage>.from(sta|te));
  }

  void escucharMensaje(dynamic payload) {
    state.add(ChatMessage(de: payload['de'], mensaje: payload['mensaje']));
    emit(List<ChatMessage>.from(state));
  }

  void addMessage(UsuarioDb mainUser, UsuarioDb contactUser, String message,
      BuildContext context) {
    final socketService = context.read<SocketService>();
    socketService.emitir('mensaje-personal',
        {'de': mainUser.uid, 'para': contactUser.uid, 'mensaje': message});
    state.add(ChatMessage(de: mainUser.uid, mensaje: message));
    emit(List<ChatMessage>.from(state));
  }
}

class ChatServiceCubit extends Cubit<String> {
  ChatServiceCubit() : super('');

  TextEditingController inputController = TextEditingController();

  void leerMensaje() {
    // print('Controller Value: ${inputController.text}');
    emit(inputController.text);
  }

  void enviarMensaje() {
    inputController.clear();
    emit(inputController.text);
  }
}
