import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  post(
      {required String url,
      required body,
      required String token,
      String? contentType}) async {
    final response = await dio.post(url,
        data: body,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': contentType
        }));
    return response.data;
  }

  get({required String url, String? token}) async {
    final response = await dio.get(url,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data;
  }
}
