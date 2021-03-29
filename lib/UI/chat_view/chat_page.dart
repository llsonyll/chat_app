import 'package:chat_app/UI/chat_view/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => InputCubit()),
      ],
      child: BlocBuilder<ChatCubit, List<String>>(
        builder: (context, snapshot) {
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
                Flexible(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemBuilder: (__, i) => Text('$i'),
                    itemCount: 50,
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
                                    context
                                        .read<InputCubit>()
                                        .imprimirController();
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
