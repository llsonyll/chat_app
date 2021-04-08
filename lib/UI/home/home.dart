import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    final auth = context.read<AuthCubit>();
    final socket = context.read<SocketService>();
    return BlocProvider(
      create: (context) => UsuariosListCubit(context)..init(),
      child: BlocBuilder<UsuariosListCubit, List<UsuarioDb>>(
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  // LogOut
                  context.read<AuthCubit>().logout();
                  socket.disconnect();
                  pushReplacementToPage(context, Login());
                },
              ),
              title: Text('Usuario: ${auth.user.nombre ?? 'Usuario'}'),
              actions: [
                BlocBuilder<SocketService, ServerStatus>(
                  builder: (context, serverState) {
                    return ServerState(estado: serverState);
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
                  final UsuarioDb user = snapshot[index];
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

  final UsuarioDb user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(user.nombre),
      subtitle: Text(user.email),
      trailing:
          Icon(Icons.circle, color: user.online ? Colors.green : Colors.red),
      onTap: () {
        pushToPage(context, ChatPage());
      },
    );
  }
}

class ServerState extends StatelessWidget {
  const ServerState({Key key, @required this.estado}) : super(key: key);

  final ServerStatus estado;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.purple,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            estado == ServerStatus.Online
                ? Icon(
                    Icons.check_circle,
                    color: Colors.lightGreen,
                    size: 18.0,
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                    size: 18.0,
                  ),
            estado == ServerStatus.Online
                ? Text(
                    'Online',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  )
                : Text(
                    'Offline',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
