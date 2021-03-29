import 'package:chat_app/domain/models/usuario.dart';
import 'package:flutter/material.dart';

final usuarios = [
  Usuario(
      uid: '1', email: 'usuario1@test.com', name: 'usuario1', online: false),
  Usuario(
      uid: '2', email: 'usuario2@test.com', name: 'usuario2', online: false),
  Usuario(uid: '3', email: 'usuario3@test.com', name: 'usuario3', online: true),
];

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuario'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: usuarios.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          final Usuario user = usuarios[index];
          return UsuarioListTile(user: user);
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

  final Usuario user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing:
          Icon(Icons.circle, color: user.online ? Colors.green : Colors.red),
    );
  }
}
