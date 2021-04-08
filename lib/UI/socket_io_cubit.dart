import 'package:chat_app/enviroment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService extends Cubit<ServerStatus> {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  SocketService() : super(null);

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emitir => this._socket.emit;

  void connect() {
    // Dart client
    this._socket = IO.io(
        Environment.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableForceNew()
            .build());

    this._socket.on('connect', (_) {
      emit(ServerStatus.Online);
    });

    this._socket.on('disconnect', (_) {
      emit(ServerStatus.Offline);
    });

    this._socket.on('nuevo_mensaje', (payload) {
      print('new-message: $payload');
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}

// class SocketService with ChangeNotifier {
//   ServerStatus _serverStatus = ServerStatus.Connecting;
//   IO.Socket _socket;

//   ServerStatus get serverStatus => this._serverStatus;

//   IO.Socket get socket => this._socket;
//   Function get emit => this._socket.emit;

//   SocketService() {
//     this._initConfig();
//   }

//   void _initConfig() {
//     // Dart client
//     this._socket = IO.io(
//         'https://socketsflutter.herokuapp.com/',
//         IO.OptionBuilder()
//             .setTransports(['websocket'])
//             .enableAutoConnect()
//             .build());

//     this._socket.on('connect', (_) {
//       this._serverStatus = ServerStatus.Online;
//       notifyListeners();
//     });

//     this._socket.on('disconnect', (_) {
//       this._serverStatus = ServerStatus.Offline;
//       notifyListeners();
//     });

//     this._socket.on('nuevo_mensaje', (payload) {
//       print('new-message: $payload');
//     });
//   }
// }
