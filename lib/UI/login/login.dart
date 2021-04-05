// import 'package:chat_app/UI/home/home.dart';
import 'package:chat_app/UI/home/home.dart';
import 'package:chat_app/UI/register/register.dart';
import 'package:chat_app/UI/widgets/custom_text_field.dart';
import 'package:chat_app/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStatus>(
        listener: (context, snapshot) {
          if (snapshot == LoginStatus.Success) {
            pushReplacementToPage(
              context,
              Home(),
            );
          } else if (snapshot == LoginStatus.Error) {
            print('Error Usuario');
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Color(0xffF2F2F2),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 50.0),
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            controller:
                                context.read<LoginCubit>().emailController,
                          ),
                          const SizedBox(height: 20.0),
                          CustomTextField(
                              hint: 'Contraseña',
                              icon: Icons.lock_outline,
                              controller: context
                                  .read<LoginCubit>()
                                  .passwordController),
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
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  // pushReplacementToPage(context, Home());
                                  context.read<LoginCubit>().login();
                                },
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
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                          const SizedBox(height: 5.0),
                          InkWell(
                            onTap: () {
                              pushToPage(context, Register());
                            },
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
                      InkWell(
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
