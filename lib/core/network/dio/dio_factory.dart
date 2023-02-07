import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';

class DioFactory {
  final String baseUrl;

  DioFactory({required this.baseUrl});

  BaseOptions _createBaseOptions() => BaseOptions(
        baseUrl: baseUrl,
        headers: {"Authorization": "Bearer 156c7ce8e18b47b98a0a459cb348684f"},
        receiveTimeout: 60 * 1000,
        sendTimeout: 60 * 1000,
        connectTimeout: 60 * 1000,
      );

  Dio create() =>
      Dio(_createBaseOptions())..interceptors.addAll([AwesomeDioInterceptor()]);
}
