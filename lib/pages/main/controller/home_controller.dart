import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:my_wanandroid/api/api_service.dart';
import 'package:my_wanandroid/base/base_controller.dart';
import 'package:my_wanandroid/model/banner_info.dart';
import 'package:my_wanandroid/model/home_article.dart';
import 'package:my_wanandroid/utils/toast_util.dart';

class HomeController extends BaseController {
  final ScrollController scrollController = ScrollController();
  //banner列表
  RxList<BannerInfo> bannerList = <BannerInfo>[].obs;
  //首页文章列表
  RxList<HomeArticleInfo> homeArticleList = <HomeArticleInfo>[].obs;
  //顶部栏透明度
  RxDouble opacity = 0.0.obs;
  //刷新控制器
  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );
  //是否加载成功
  RxBool isLoading = true.obs;

  //文案内容
  RxString loadFailedText = "加载失败".obs;
  @override
  Future<void> loadData() async {
    await getBannerList();
  }

  void _scrollerListener() {
    double newOpacity = scrollController.offset / 100;
    if (newOpacity > 1.0) newOpacity = 1.0;
    if (newOpacity < 0) newOpacity = 0;
    if (opacity.value != newOpacity) {
      opacity.value = newOpacity;
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      _scrollerListener();
    });
  }

  Future<void> getBannerList() async {
    try {
      final result = await ApiService().getBannerList();
      if (result.isSuccess) {
        bannerList.value = result.data ?? [];
      }
    } catch (e) {
      ToastUtil.show(e.toString());
      // 刷新完成
      easyRefreshController.finishRefresh();
      // 加载完成
      easyRefreshController.finishLoad();
    }
  }

  Future<void> getHomeArticleList() async {
    try {
      final result = await ApiService().getHomeArticleList();
      homeArticleList.value = result.data?.datas ?? [];
      if (result.isSuccess) {
        easyRefreshController.finishRefresh();
        easyRefreshController.finishLoad();
        isLoading.value = true;
        loadFailedText.value = "加载成功";
      }
    } catch (e) {
      ToastUtil.show(e.toString());
      easyRefreshController.finishRefresh();
      easyRefreshController.finishLoad();
      isLoading.value = false;
      loadFailedText.value = e.toString();
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await getHomeArticleList();
    await getBannerList();
  }
}
