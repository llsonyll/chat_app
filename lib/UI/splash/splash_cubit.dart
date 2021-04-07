import 'package:chat_app/UI/login/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LogState { InvalidToken, ValidToken }

class SplashCubit extends Cubit<LogState> {
  SplashCubit() : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    final isTokenValid = await context.read<AuthCubit>().isTokenValid();
    if (isTokenValid) {
      emit(LogState.ValidToken);
    } else {
      emit(LogState.InvalidToken);
    }
  }
}
