import 'package:flutter/material.dart';

// import 'UI/home/home.dart';
import 'UI/splash/splash.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Splash(),
    );
  }
}
