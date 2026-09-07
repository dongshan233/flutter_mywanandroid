import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:my_wanandroid/pages/main/controller/home_controller.dart';
import 'package:my_wanandroid/routes/route_utils.dart';
import 'package:my_wanandroid/routes/routes.dart';
import 'package:my_wanandroid/widget/loading_error_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with AutomaticKeepAliveClientMixin<HomeWidget> {
  final HomeController _homeController = Get.find<HomeController>();
  int currentIndex = 0;
  Widget _indicatorList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _homeController.bannerList.length,
        (index) => Container(
          width: 20,
          height: 2,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Color(0xFF0077f1)
                : Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _bannerList() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          CarouselSlider(
            items: _homeController.bannerList
                .map(
                  (info) => Image.network(
                    info.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Text("加载失败"),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 210,
              autoPlay: true,
              aspectRatio: 2.0,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) => {
                setState(() {
                  currentIndex = index;
                }),
              },
            ),
          ),
          Positioned(bottom: 10, left: 0, right: 10, child: _indicatorList()),
        ],
      ),
    );
  }

  Widget _homeArticleList() {
    return SliverToBoxAdapter(
      child: ListView.builder(
        //移除默认padding
        padding: EdgeInsets.zero,
        itemCount: _homeController.homeArticleList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final article = _homeController.homeArticleList[index];
          return InkWell(
            onTap: () {
              RouteUtils.to(Routes.webView);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    if (article.desc.isNotEmpty)
                      Text(
                        article.desc,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                      ),
                    if (article.desc.isNotEmpty) SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${article.superChapterName}/${article.chapterName}',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        Text(
                          article.niceDate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _loadFailed() {
    return Obx(() {
      return LoadingErrorWidget(
        error: _homeController.loadFailedText.value,
        retry: () async {
          _homeController.onReady();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      debugPrint('home-isLoading $_homeController.isLoading.value');
      debugPrint('build obs');
      debugPrint(_homeController.bannerList.toString());
      if (_homeController.isLoading.value) {
        return EasyRefresh.builder(
          controller: _homeController.easyRefreshController,
          refreshOnStart: true,
          onRefresh: () async {
            await _homeController.getHomeArticleList();
          },
          childBuilder: (context, physics) {
            return Stack(
              children: [
                CustomScrollView(
                  controller: _homeController.scrollController,
                  physics: physics,
                  slivers: [
                    //banner列表
                    _bannerList(),
                    SliverToBoxAdapter(child: const SizedBox(height: 10)),
                    _homeArticleList(),
                    if (_homeController.homeArticleList.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Text(
                              '我是有底线的',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                _buildAppBar(),
              ],
            );
          },
        );
      } else {
        return _loadFailed();
      }
    });
  }

  Widget _buildAppBar() {
    return Obx(() {
      return Container(
        padding: EdgeInsets.only(top: 45, left: 20),
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: _homeController.opacity.value),
          boxShadow: _homeController.opacity.value > 0.5
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          'Android',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black.withValues(
              alpha: _homeController.opacity.value,
            ),
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
