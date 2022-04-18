import 'package:simple_connection_checker/simple_connection_checker.dart';

class ConnectionUtils {
  static bool isConnected() {
    Future<bool> connectionFuture =
        SimpleConnectionChecker.isConnectedToInternet();
    connectionFuture.then((value) {
      return value;
    });
    return false;
  }
}
