import 'dart:developer';
import 'dart:io';
class Helpers{

  static Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        log(result.toString());
        return false;
      }
    } on SocketException catch (e) {
      log(e.message);
      return false;
    }
  }
}