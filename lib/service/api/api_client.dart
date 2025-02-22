import 'dart:convert';
import 'package:http/http.dart' as http;

class APIRequestClient<T> {
  final String baseurl;
  
  APIRequestClient(this.baseurl);

  Future<T> fetchData(String endpoint, {Map<String,String>? headers}) async {
    final response = await http.get(
      Uri.parse('$baseurl/$endpoint'),
      headers: headers);
    if(response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse;
    } else {
      throw Exception("Failed to load Data");
    }
  }
}