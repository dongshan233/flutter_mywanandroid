import 'package:dio/dio.dart';
import 'package:my_wanandroid/api/api_constant.dart';
import 'package:my_wanandroid/http/base_result.dart';
import 'package:my_wanandroid/http/nework_manager.dart';
import 'package:my_wanandroid/model/banner_info.dart';
import 'package:my_wanandroid/model/home_article.dart';
import 'package:my_wanandroid/model/user_info.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  final NetworkManager _networkManager = NetworkManager();
  ApiService._internal();

  //banner列表
  Future<BaseResult<List<BannerInfo>>> getBannerList({
    Map<String, dynamic>? params,
  }) async {
    final result = await _networkManager.get(
      ApiConstant.bannerList,
      queryParameters: params,
    );
    if (result.data is List) {
      List<BannerInfo> bannerList = (result.data as List)
          .map((e) => BannerInfo.fromJson(e as Map<String, dynamic>))
          .toList();
      return BaseResult(
        errorCode: result.errorCode,
        errorMsg: result.errorMsg,
        data: bannerList,
      );
    }
    return BaseResult(
      errorCode: result.errorCode,
      errorMsg: result.errorMsg,
      data: [],
    );
  }

  Future<BaseResult<HomeArticle>> getHomeArticleList({
    Map<String, dynamic>? params,
  }) async {
    final result = await _networkManager.get(
      ApiConstant.homeArticleList,
      queryParameters: params,
    );
    return BaseResult(
      errorCode: result.errorCode,
      errorMsg: result.errorMsg,
      data: HomeArticle.fromJson(result.data as Map<String, dynamic>),
    );
  }

  Future<BaseResult<UserInfo>> login({Map<String, dynamic>? params}) async {
    final result = await _networkManager.post(
      ApiConstant.login,
      data: params,
      contentType: Headers.formUrlEncodedContentType,
    );
    if (result.data == null) {
      return BaseResult(
        errorCode: result.errorCode,
        errorMsg: result.errorMsg,
        data: null,
      );
    }
    return BaseResult(
      errorCode: result.errorCode,
      errorMsg: result.errorMsg,
      data: UserInfo.fromJson(result.data as Map<String, dynamic>),
    );
  }
}
