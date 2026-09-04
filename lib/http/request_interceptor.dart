import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_wanandroid/http/network_config.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(NetworkConfig.defaultHeaders());
    handler.next(options);
  }

  void _onRequest(RequestOptions options) {
    if (NetworkConfig.enableLog) {
      debugPrint(
        '\n=========================== 🔥🔥🔥请求开始🔥🔥🔥 ===========================',
      );
      debugPrint('URL: ${options.uri}');
      debugPrint('Method: ${options.method}');
      debugPrint('Headers: ${options.headers}');
      if (options.data != null) {
        debugPrint('Data:${options.data}');
      }
      if (options.queryParameters.isNotEmpty) {
        debugPrint('Params: ${options.queryParameters}');
      }

      debugPrint(
        '=========================== 🔥🔥🔥请求结束🔥🔥🔥 ===========================\n',
      );
    }
  }
}
