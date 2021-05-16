import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

Future<dynamic> gec({String text}) async {
  final response = await http
      .get(Uri.parse("https://2a7a059dc95c.ngrok.io/predict?text=$text"));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    print(data);
    return data;
  } else {
    print(response.statusCode);
  }
}
