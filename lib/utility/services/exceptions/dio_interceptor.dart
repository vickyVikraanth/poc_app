import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  static const String baseUrl = "https://run.mocky.io/v3/";
  static const String endPoint = 'c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf';

  Dio getDio(String url) {
    final Dio _dio = Dio();
    _dio.options.baseUrl = url;
    _dio.interceptors.addAll([
      TokenOnHeaderInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        request: true,
        logPrint: (object) {
          print("error on dio logger:: ${object}");
        },
      )
    ]);
    return _dio;
  }
}

class TokenOnHeaderInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    //options.headers['Authorization'] = 'Bearer $auth';
    super.onRequest(options, handler);
  }
}
