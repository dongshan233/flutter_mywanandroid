import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wanandroid/api/api_service.dart';
import 'package:my_wanandroid/base/base_controller.dart';
import 'package:my_wanandroid/http/base_result.dart';
import 'package:my_wanandroid/model/system_tree.info.dart';

class SystemController
    extends BaseController<BaseResult<List<SystemTreeInfo>>> {
  final ScrollController scorllController = ScrollController();
  RxDouble opacity = 0.0.obs;
  void _scrollerListener() {
    //透明度计算
    double newOpacity = scorllController.offset / 100;
    if (newOpacity > 1.0) newOpacity = 1.0;
    if (newOpacity < 0.0) newOpacity = 0.0;
    if (opacity.value != newOpacity) {
      opacity.value = newOpacity;
    }
  }

  RxMap<dynamic, dynamic> colorCache = {}.obs;
  Color getColor(String key) {
    if (!colorCache.containsKey(key)) {
      colorCache[key] = Color(0xFF000000 + Random().nextInt(0xffffff));
    }
    return colorCache[key];
  }

  @override
  void onInit() {
    super.onInit();
    scorllController.addListener(() {
      _scrollerListener();
    });
  }

  @override
  Future<void> loadData() async {
    await getSystemTreeList();
  }

  Future<void> getSystemTreeList() async {
    try {
      final result = await ApiService().getSystemTreeList();
      if (result.isSuccess) {
        setSuccess(result);
      }
    } catch (e) {
      setError(e.toString());
    }
  }
}
