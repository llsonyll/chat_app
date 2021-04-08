import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/auth_cubit.dart';
// import 'UI/home/home.dart';
import 'UI/socket_io_cubit.dart';
import 'UI/splash/splash.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: Splash(),
      ),
    );
  }
}
