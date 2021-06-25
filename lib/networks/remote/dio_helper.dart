import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio();
  }

  static Future<Response> getData({String url, Map<String, dynamic> query}) {
    dio.options.headers = {
      "Content-Type": "application/json",
    };
    return dio.get(url, queryParameters: query ?? null);
  }

  static Future<Response> postData({
    String url,
    Map<String, dynamic> query,
    Map<String, dynamic> data,
  }) async {
    return await dio.post(
      url,
      queryParameters: query ?? null,
      data: data ?? null,
    );
  }
}
