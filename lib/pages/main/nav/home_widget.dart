import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:my_wanandroid/pages/main/controller/home_controller.dart';
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
      if (_homeController.isLoading.value) {
        return Text('ddd');
      } else {
        return _loadFailed();
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
