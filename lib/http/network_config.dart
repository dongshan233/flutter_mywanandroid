import 'package:my_wanandroid/api/api_constant.dart';
import 'package:my_wanandroid/utils/storage_util.dart';

class NetworkConfig {
  //基地址
  static const String baseUrl = ApiConstant.baseUrl;
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;

  /// 发送超时时间（毫秒）
  static const int sendTimeout = 10000;

  /// 是否启用日志
  static const bool enableLog = true;

  static Map<String, String> defaultHeaders() {
    return {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie':
          'loginUserName=${StorageUtil.getString(StorageKey.loginUsername)}; loginUserPassword=${StorageUtil.getString(StorageKey.loginPassword)}',
    };
  }
}
