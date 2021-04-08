// import 'package:chat_app/domain/models/usuario.dart';
import 'package:chat_app/UI/auth_cubit.dart';
import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

import '../../enviroment.dart';

class UsuariosListCubit extends Cubit<List<UsuarioDb>> {
  UsuariosListCubit(this.context) : super([]);

  final BuildContext context;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init() async {
    // Llenar los datos de la lista...
    final url = Uri.parse('${Environment.apiUrl}/usuarios');
    try {
      final resp = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': await context.read<AuthCubit>().getToken(),
        },
      );

      final ListaUsuarios respuesta = listaUsuariosFromJson(resp.body);
      emit(respuesta.usuarios);
    } catch (e) {
      print('error');
    }
  }

  Future<void> onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }
}
