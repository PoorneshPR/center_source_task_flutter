import 'package:http/http.dart' as http;

class AllImageServices {
  static Future<String?> getApiData({String? text}) async {
    var client = http.Client();
    try {
      var response = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=29903728-b5ddee66671f05af16789286c&q=$text&image_type=photo'));
      if (response.statusCode == 200) {
        if (response != null) {
          final jsonRes = response.body;
          client.close();
          return jsonRes;
        }
      } else {
        throw "failed to load data";
      }
    } catch (err) {
      client.close();
      return null;
    }
  }
}
