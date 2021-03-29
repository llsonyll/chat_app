import 'package:chat_app/UI/chat_view/chat_cubit.dart';
import 'package:chat_app/domain/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit()..init()),
        BlocProvider(create: (context) => InputCubit()),
      ],
      child: BlocBuilder<ChatCubit, List<ChatMessage>>(
        builder: (context, chatList) {
          return Scaffold(
            appBar: AppBar(
              // leading: Icon(Icons.forward_10_rounded, color: Colors.black),
              elevation: 2,
              backgroundColor: Color(0xffF2F2F2),
              centerTitle: true,
              title: Column(
                children: [
                  CircleAvatar(child: Icon(Icons.person)),
                  Text(
                    'Nombre',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                const SizedBox(height: 10.0),
                Flexible(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    // reverse: true,
                    itemCount: chatList.length,
                    itemBuilder: (__, i) {
                      final ChatMessage mensaje = chatList[i];
                      return mensaje.uid == "123"
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10.0, top: 5.0, bottom: 5.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  mensaje.mensaje,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, top: 5.0, bottom: 5.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  mensaje.mensaje,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ),
                BlocBuilder<InputCubit, String>(
                  builder: (context, inputController) {
                    return Container(
                      color: Color(0xffF2F2F2),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: context
                                      .read<InputCubit>()
                                      .inputController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Test',
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (text) {
                                    context.read<InputCubit>().leerMensaje();
                                  },
                                ),
                              ),
                              IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Icon(
                                  Icons.send,
                                  color: inputController.length > 0
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: inputController.length > 0
                                    ? () {
                                        context
                                            .read<InputCubit>()
                                            .enviarMensaje();
                                        context
                                            .read<ChatCubit>()
                                            .addMessage(inputController);
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
