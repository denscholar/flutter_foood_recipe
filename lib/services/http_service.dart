import 'package:dio/dio.dart';

import '../constant.dart';

class HTTPService {
  static final HTTPService _singleton = HTTPService._internal();

  final _dio = Dio();

  factory HTTPService() {
    return _singleton;
  }

  HTTPService._internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {
      "Content-Type": "application/json",
    };

    if (bearerToken != null) {
      headers['Authorization'] = "Bearer $bearerToken";
    }
    final options = BaseOptions(
        baseUrl: apiBaseUrl,
        headers: headers,
        validateStatus: (status) {
          if (status == null) return false;
          return status < 500;
        });

    _dio.options = options;
  }

  // function that send a post request to a specific endpoint
Future<Response?> post(String path, Map data) async {
  try {
    final response = await _dio.post(path, data: data);
    return response;
  } on DioException  catch (e) {
    print('DioError: ${e.message}');
    return null;
  } catch (e) {
    print('Unexpected error: $e');
    return null;
  }
}


  // function for get request
  Future<Response?> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
