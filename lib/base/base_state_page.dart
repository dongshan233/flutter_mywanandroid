import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wanandroid/base/base_controller.dart';
import 'package:my_wanandroid/widget/loading_empty.dart';
import 'package:my_wanandroid/widget/loading_error_widget.dart';
import 'package:my_wanandroid/widget/loading_widget.dart';

abstract class BaseStatePage<D, C extends BaseController<D>>
    extends GetView<C> {
  const BaseStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: _buildBody());
  }

  Widget _buildBody() {
    return controller.obx(
      (data) => _buildContent(data),
      onLoading: buildLoading(),
      onError: (error) => buildError(error ?? '未知错误'),
      onEmpty: buildEmpty(),
    );
  }

  Widget _buildContent([D? data]) {
    if (data == null || (data is List && data.isEmpty)) {
      return buildEmpty();
    }
    return buildSuccessContent(data);
  }

  PreferredSizeWidget? buildAppBar() => null;
  //成功页面，必须复写
  Widget buildSuccessContent(D data);
  //加载页面，可选复写
  Widget buildLoading() =>
      const Center(child: LoadingWidget(backgroundColor: Colors.transparent));
  //错误页面，可选复写
  Widget buildError(String error) =>
      LoadingErrorWidget(error: error, retry: controller.retry);
  //空数据页面，可选复写
  Widget buildEmpty() => LoadingEmpty();
}
