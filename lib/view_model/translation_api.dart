import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Translate {
  Future<dynamic> translate({String text, String toLanguage}) async {
    final String key = "AIzaSyAxHcXzqV6YWKJZ9i5VKgmm1IPlJjy5hfc";
    final response = await http.post(
      Uri.parse(
          "https://translation.googleapis.com/language/translate/v2?key=$key&q=$text&target=$toLanguage"),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw (Exception);
    }
  }
}
