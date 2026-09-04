import 'package:dio/dio.dart';
import 'package:my_wanandroid/http/base_result.dart';
import 'package:my_wanandroid/http/network_config.dart';
import 'package:my_wanandroid/http/request_interceptor.dart';
import 'package:my_wanandroid/http/response_interceptor.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();
  factory NetworkManager() => _instance;

  late Dio _dio;
  final List<CancelToken> _cancelTokens = [];

  NetworkManager._internal() {
    _initDio();
  }

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: NetworkConfig.baseUrl,
        connectTimeout: Duration(milliseconds: NetworkConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: NetworkConfig.receiveTimeout),
        sendTimeout: Duration(milliseconds: NetworkConfig.sendTimeout),
      ),
    );
    _dio.interceptors.add(RequestInterceptor());
    _dio.interceptors.add(ResponseInterceptor());
  }

  //通用请求方法
  Future<BaseResult<dynamic>> _request(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    String? contentType,
  }) async {
    try {
      return await _fetchFromNetwork(
        path,
        method: method,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        cancelToken: cancelToken,
        contentType: contentType,
      );
    } on DioException catch (e) {
      _cancelTokens.removeWhere((token) => token.isCancelled);
      throw _handleError(e);
    }
  }

  Future<BaseResult<dynamic>> _fetchFromNetwork(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    String? contentType,
  }) async {
    final options = Options(
      method: method,
      headers: headers,
      contentType: contentType,
    );

    //创建取消令牌
    final token = cancelToken ?? CancelToken();
    _cancelTokens.add(token);
    final response = await _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    _cancelTokens.remove(token);
    final result = BaseResult.fromMap(response.data);
    return result;
  }

  dynamic _handleError(DioException error) {
    switch (error.type) {
      case DioException.connectionTimeout:
        return NetworkError('连接超时，请检查网络');
      case DioException.sendTimeout:
        return NetworkError('发送超时，请检查网络');
      case DioException.receiveTimeout:
        return NetworkError('接收超时，请检查网络');
      case DioException.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return NetworkError('请求参数错误');
          case 401:
            return NetworkError('未授权，请重新登录');
          // case 402:
          // return NetworkError('');
          case 403:
            return NetworkError('拒绝访问');

          case 404:
            return NetworkError('请求地址不存在');

          case 500:
            return NetworkError('服务器错误，状态码: $statusCode');
          default:
            return NetworkError('服务器错误，状态码: $statusCode');
        }
      case DioExceptionType.cancel:
        return NetworkError('请求已取消');
      case DioExceptionType.connectionError:
        return NetworkError('网络错误，请检查网络连接');
      default:
        return NetworkError('未知错误');
    }
  }

  //GET
  Future<BaseResult<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    return _request(
      path,
      method: 'GET',
      queryParameters: queryParameters,
      headers: headers,
      cancelToken: cancelToken,
    );
  }

  /// POST请求
  Future<BaseResult<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    String? contentType,
  }) async {
    return _request(
      path,
      method: 'POST',
      data: data,
      queryParameters: queryParameters,
      headers: headers,
      cancelToken: cancelToken,
      contentType: contentType,
    );
  }

  /// PUT请求
  Future<BaseResult<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    return _request(
      path,
      method: 'PUT',
      data: data,
      queryParameters: queryParameters,
      headers: headers,
      cancelToken: cancelToken,
    );
  }

  /// DELETE请求
  Future<BaseResult<dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    return _request(
      path,
      method: 'DELETE',
      queryParameters: queryParameters,
      headers: headers,
      cancelToken: cancelToken,
    );
  }

  /// 上传文件
  Future<BaseResult<dynamic>> upload(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final options = Options(method: 'POST', headers: headers);

      final token = cancelToken ?? CancelToken();
      _cancelTokens.add(token);

      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: token,
        onSendProgress: onSendProgress,
      );

      _cancelTokens.remove(token);

      // 包装响应数据
      final result = BaseResult.fromMap(response.data);

      // 检查业务状态码 - 不再抛出异常，由调用方处理
      return result;
    } on DioException catch (e) {
      _cancelTokens.removeWhere((token) => token.isCancelled);
      throw _handleError(e);
    }
  }

  /// 下载文件
  Future<dynamic> download(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final options = Options(headers: headers);

      final token = cancelToken ?? CancelToken();
      _cancelTokens.add(token);

      final response = await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: token,
        onReceiveProgress: onReceiveProgress,
      );

      _cancelTokens.remove(token);
      return response.data;
    } on DioException catch (e) {
      _cancelTokens.removeWhere((token) => token.isCancelled);
      throw _handleError(e);
    }
  }

  /// 取消所有请求
  void cancelAll() {
    for (final token in _cancelTokens) {
      if (!token.isCancelled) {
        token.cancel('Canceled by user');
      }
    }
    _cancelTokens.clear();
  }

  /// 取消指定请求
  void cancel(CancelToken token) {
    if (!token.isCancelled) {
      token.cancel('Canceled by user');
    }
    _cancelTokens.remove(token);
  }

  /// 获取Dio实例（用于扩展）
  Dio get dio => _dio;
}

class NetworkError implements Exception {
  final String message;
  NetworkError(this.message);
  @override
  String toString() => message;
}
