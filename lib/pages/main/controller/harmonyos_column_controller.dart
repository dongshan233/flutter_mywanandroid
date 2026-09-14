import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_wanandroid/api/api_service.dart';
import 'package:my_wanandroid/base/base_controller.dart';
import 'package:my_wanandroid/http/base_result.dart';
import 'package:my_wanandroid/model/harmony_column_info.dart';

class HarmonyosColumnController
    extends BaseController<BaseResult<HarmonyColumn>> {
  RxInt currentIndex = 0.obs;

  int get currentIndexValue => currentIndex.value;
  set currentIndexValue(int value) => currentIndex.value = value;

  //标签栏
  RxList<String> tabList = <String>[].obs;
  @override
  Future<void> loadData() async {
    await getHarmonyosColumnList();
  }

  Future<void> getHarmonyosColumnList() async {
    try {
      final result = await ApiService().getHarmonyColumnList();
      tabList.add(result.data?.tools.name ?? '');
      tabList.add(result.data?.links.name ?? '');
      tabList.add(result.data?.open_sources.name ?? '');
      await Future.delayed(Duration(seconds: 1));
      setSuccess(result);
    } catch (e) {
      debugPrint(e.toString());
      setError('获取失败');
    }
  }
}
