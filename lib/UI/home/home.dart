import 'package:chat_app/UI/chat_view/chat_page.dart';
import 'package:chat_app/UI/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../navigator_utils.dart';
import 'home_cubit.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsuariosListCubit()..init(),
      child: BlocConsumer<UsuariosListCubit, List<String>>(
        listener: (context, snapshot) {},
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Usuario'),
              actions: [
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    // LogOut
                    pushReplacementToPage(context, Login());
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
