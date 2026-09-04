import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_wanandroid/http/network_config.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _onResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _onError(err);
    handler.next(err);
  }

  void _onResponse(Response response) {
    if (NetworkConfig.enableLog) {
      debugPrint(
        '\n=========================== 🔥🔥🔥响应开始🔥🔥🔥 ===========================',
      );
      debugPrint('URL: ${response.requestOptions.uri}');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Data: ${response.data}');
      debugPrint(
        '=========================== 🔥🔥🔥响应结束🔥🔥🔥 ===========================\n',
      );
    }
  }

  void _onError(DioException error) {
    if (NetworkConfig.enableLog) {
      debugPrint('\n===== 🔥🔥🔥错误开始🔥🔥🔥 =====');
      debugPrint('URL: ${error.requestOptions.uri}');
      debugPrint('Error: ${error.message}');
      if (error.response != null) {
        debugPrint('Status Code: ${error.response?.statusCode}');
        debugPrint('Response: ${error.response?.data}');
      }
      debugPrint('===== 🔥🔥🔥错误结束🔥🔥🔥 =====\n');
    }
  }
}
