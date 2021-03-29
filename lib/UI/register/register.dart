import 'package:chat_app/UI/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/tag_chat.png',
                      height: 120,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Registrate',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      hint: 'Nombre',
                      icon: Icons.person_outline,
                      controller: null,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      hint: 'Correo',
                      icon: Icons.mail_outline,
                      controller: null,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      hint: 'Contraseña',
                      icon: Icons.lock_outline,
                      controller: null,
                    ),
                    const SizedBox(height: 30.0),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green[500],
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2.5, 2.5),
                                spreadRadius: 0.2,
                                blurRadius: 5.0,
                              )
                            ]),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Listo',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                              // letterSpacing: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
