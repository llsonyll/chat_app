import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../domain/models/usuario.dart';
import '../../navigator_utils.dart';
import '../chat_view/chat_page.dart';
import '../auth_cubit.dart';
import '../login/login.dart';
import '../socket_io_cubit.dart';
import 'home_cubit.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsuarioDb user = context.read<AuthCubit>().user;
    final socket = context.read<SocketService>();
    return BlocProvider(
      create: (context) => UsuariosListCubit()..init(),
      child: BlocBuilder<UsuariosListCubit, List<String>>(
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Usuario: ${user.nombre ?? 'Usuario'}'),
              actions: [
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    // LogOut
                    context.read<AuthCubit>().logout();
                    socket.disconnect();
                    pushReplacementToPage(context, Login());
                  },
                ),
                BlocBuilder<SocketService, ServerStatus>(
                  builder: (context, snasphot) {
                    final ServerStatus state = snasphot;
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: state == ServerStatus.Online
                            ? Colors.green
                            : Colors.red,
                      ),
                    );
                  },
                ),
              ],
            ),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: context.read<UsuariosListCubit>().refreshController,
              onRefresh: context.read<UsuariosListCubit>().onRefresh,
              onLoading: context.read<UsuariosListCubit>().onLoading,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.length,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (context, index) {
                  final String user = snapshot[index];
                  return UsuarioListTile(user: user);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class UsuarioListTile extends StatelessWidget {
  const UsuarioListTile({
    Key key,
    @required this.user,
  }) : super(key: key);

  final String user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(user),
      subtitle: Text('User Email'),
      trailing: Icon(Icons.circle, color: Colors.green),
      onTap: () {
        pushToPage(context, ChatPage());
      },
    );
  }
}
