import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);
  Future<Map<String, dynamic>> getData() async {
    print(url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      const JsonDecoder decoder = JsonDecoder();
      return decoder.convert(data);
    } else {
      return null;
    }
  }
}
