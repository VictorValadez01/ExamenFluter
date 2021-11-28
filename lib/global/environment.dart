import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.100.42:3002/api'
      : 'http://localhost:3002/api';
  static String socketUrl = Platform.isAndroid
      ? 'http:// 192.168.100.42:3002/api'
      : 'http://localhost:3002/api';
}
