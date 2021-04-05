import 'dart:io';

class Environment {
  // Servidor Servicios REST
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.1.30:3000/api'
      : 'http://localhost:3000/api';
  // Servidor de sockets
  static String socketUrl =
      Platform.isAndroid ? 'http://192.168.1.30:3000' : 'http://localhost:3000';
}
