import 'package:simple_connection_checker/simple_connection_checker.dart';

class ConnectionUtils {
  Future<bool> isConnected() async {
    return await SimpleConnectionChecker.isConnectedToInternet();
  }
}
