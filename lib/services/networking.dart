import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({
    required this.domain,
    required this.path,
    required this.params,
  });

  final String domain;
  final String path;
  final Map<String, String> params;
  var _url;

  Future getData() async {
    _url = Uri.https(domain, path, params);
    http.Response response = await http.get(_url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
