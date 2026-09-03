import 'package:dio/dio.dart';
import 'package:my_wanandroid/http/network_config.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();
  factory NetworkManager() => _instance;

  late Dio _dio;

  NetworkManager._internal() {
    _initDio();
  }

  void _initDio() {
    _dio = Dio(
      BaseOptions(baseUrl:NetworkConfig.baseUrl,
      connectTimeout: Duration(milliseconds: NetworkConfig.connectTimeout),
      receiveTimeout: Duration(milliseconds: NetworkConfig.receiveTimeout),
      sendTimeout: Duration(milliseconds: NetworkConfig.sendTimeout),
       )
    )
  }
}
