import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30.0),
                Column(
                  children: [
                    Image.asset(
                      'assets/tag_chat.png',
                      height: 120,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Messenger',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 60.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                            color: Colors.blue[600],
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
                            'Ingresar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 50.0),

                // const SizedBox(height: 30.0),
                Column(
                  children: [
                    Text(
                      'No tienes Cuenta?',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black54),
                    ),
                    const SizedBox(height: 5.0),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Crea una ahora!',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontWeight: FontWeight.w800,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Terminos y condiciones de uso',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
