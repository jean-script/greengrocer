import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String post = 'post';
  static const String get = 'get';
  static const String put = 'put';
  static const String delete = 'delete';
  static const String patch = 'patch';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    // Headers da requisição
    final defaultHeader = headers?.cast<String, String>() ?? {}
      ..addAll({
        'Content-Type': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
      });

    Dio dio = Dio();

    try {
      Response response = await dio.request(
        url,
        options: Options(
          method: method,
          headers: defaultHeader,
        ),
        data: body,
      );

      // returno com o valor da api
      return response.data;
    } on DioException catch (error) {
      // erro do DIO
      return error.response?.data ?? {};
    } catch (error) {
      // retorno de erro generalizado
      return {};
    }
  }
}
