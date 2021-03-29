import 'package:flutter_bloc/flutter_bloc.dart';

enum LogState {
  no_user,
  new_user,
  existing_user,
}

class SplashCubit extends Cubit<LogState> {
  SplashCubit() : super(null);

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(LogState.no_user);
  }
}
