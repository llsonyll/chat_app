import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigator_utils.dart';
import '../login/login.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/mostrarAlerta.dart';
import 'register_cubit.dart';

class Register extends StatelessWidget {
  const Register({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final snackBar = SnackBar(
      content: Text('Usuario Registrado'),
      action: SnackBarAction(
        label: 'Ir a Login',
        onPressed: () {
          pushReplacementToPage(context, Login());
        },
      ),
    );
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, snapshot) {
        if (snapshot == RegisterState.SuccessState) {
          context.read<RegisterCubit>().nombreController.clear();
          context.read<RegisterCubit>().emailController.clear();
          context.read<RegisterCubit>().passwordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (snapshot == RegisterState.ErrorState) {
          mostrarAlerta(
            context,
            'Datos Invalidos',
            Icon(Icons.error_rounded),
          );
        }
      }, builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          body: SingleChildScrollView(
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
                      snapshot == RegisterState.ValidatingState
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : FittedBox(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        hint: 'Nombre',
                        icon: Icons.person_outline,
                        controller:
                            context.read<RegisterCubit>().nombreController,
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        hint: 'Correo',
                        icon: Icons.mail_outline,
                        controller:
                            context.read<RegisterCubit>().emailController,
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        hint: 'Contraseña',
                        icon: Icons.lock_outline,
                        controller:
                            context.read<RegisterCubit>().passwordController,
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
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              context.read<RegisterCubit>().register();
                            },
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
        );
      }),
    );
  }
}
