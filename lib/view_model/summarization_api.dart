import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<dynamic> summarize({String text,int sentences}) async {
  final String key = "5f84b6de20359e1f8b8602576175c14a";
  final response = await http.post(
    Uri.parse(
        "https://api.meaningcloud.com/summarization-1.0?key=$key&txt=$text&sentences=$sentences"),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  } else {
    print(response.statusCode);
  }
}
