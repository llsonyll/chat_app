// import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosListCubit extends Cubit<List<String>> {
  UsuariosListCubit() : super([]);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init() {
    state.add('usuario 1');
    state.add('usuario 2');

    emit(List<String>.from(state));
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
