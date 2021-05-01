import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> translate({String text, String toLanguage}) async {
  final response = await http.post(
    Uri.https('microsoft-translator-text.p.rapidapi.com', 'translate',
        {"to": toLanguage, "api-version": "3.0"}),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "x-rapidapi-key": "bd9d9da516msh92534814667ad69p11f0d5jsn2b6479a0bd43",
    },
    body: jsonEncode([
      {"text": text}
    ]),
  );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data;
  } else {
    throw (Exception);
  }
}
