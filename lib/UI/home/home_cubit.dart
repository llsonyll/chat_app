import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosListCubit extends Cubit<List<Usuario>> {
  UsuariosListCubit() : super([]);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init() {
    state.add(
      Usuario(
          uid: '1',
          email: 'usuario1@test.com',
          name: 'usuario1',
          online: false),
    );
    state.add(
      Usuario(
          uid: '2',
          email: 'usuario2@test.com',
          name: 'usuario2',
          online: false),
    );
    state.add(
      Usuario(
          uid: '3', email: 'usuario3@test.com', name: 'usuario3', online: true),
    );

    emit(List<Usuario>.from(state));
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
