import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.hint,
    @required this.icon,
    @required this.controller,
  }) : super(key: key);

  final String hint;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2.5, 2.5),
            spreadRadius: 0.2,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          hintStyle: TextStyle(),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
