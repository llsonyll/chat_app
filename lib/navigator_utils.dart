import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future pushToPage(BuildContext context, Widget widget) async {
  await Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => widget));
}

Future pushReplacementToPage(BuildContext context, Widget widget) async {
  await Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}
