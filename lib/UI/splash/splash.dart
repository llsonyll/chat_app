// import 'package:chat_app/UI/home/home.dart';
import 'package:chat_app/UI/login/login.dart';
import 'package:chat_app/UI/register/register.dart';
import 'package:chat_app/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_cubit.dart';

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..init(),
      child: BlocListener<SplashCubit, LogState>(
        listener: (context, snapshot) {
          if (snapshot == LogState.no_user) {
            pushReplacementToPage(context, Login());
          } else if (snapshot == LogState.new_user) {
            pushReplacementToPage(context, Register());
          } else if (snapshot == LogState.existing_user) {
            //
            // pushReplacementToPage(context, Home());
          }
        },
        child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/tag_chat.png',
                  height: 100,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Chat-App',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
