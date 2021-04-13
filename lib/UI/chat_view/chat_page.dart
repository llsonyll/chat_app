import 'package:chat_app/UI/chat_view/chat_cubit.dart';
import 'package:chat_app/domain/models/chat_message.dart';
import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    Key key,
    @required this.mainUser,
    @required this.friendUser,
  }) : super(key: key);

  final UsuarioDb mainUser;
  final UsuarioDb friendUser;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit(friendUser)..init(context)),
        BlocProvider(create: (context) => ChatServiceCubit()),
      ],
      child: BlocBuilder<ChatCubit, List<ChatMessage>>(
        builder: (context, chatList) {
          return Scaffold(
            appBar: AppBar(
              // leading: Icon(Icons.forward_10_rounded, color: Colors.black),
              elevation: 2,
              backgroundColor: Color(0xffF2F2F2),
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CircleAvatar(child: Icon(Icons.person)),
                      Text(
                        mainUser.nombre,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                        backgroundColor: Colors.green,
                      ),
                      Text(
                        friendUser.nombre,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                const SizedBox(height: 10.0),
                Flexible(
                  child: chatList.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          // reverse: true,
                          itemCount: chatList.length,
                          itemBuilder: (__, i) {
                            final ChatMessage mensaje = chatList[i];
                            return mensaje.de == mainUser.uid
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 10.0, top: 5.0, bottom: 5.0),
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                BlocBuilder<ChatServiceCubit, String>(
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
                                      .read<ChatServiceCubit>()
                                      .inputController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Test',
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (text) {
                                    context
                                        .read<ChatServiceCubit>()
                                        .leerMensaje();
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
                                            .read<ChatServiceCubit>()
                                            .enviarMensaje();
                                        context.read<ChatCubit>().addMessage(
                                              mainUser,
                                              friendUser,
                                              inputController,
                                              context,
                                            );
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
