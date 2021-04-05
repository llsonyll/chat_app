import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, Widget content) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Usuario Invalido'),
          content: content,
        );
      },
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Usuario Invalido'),
        );
      },
    );
  }
}
