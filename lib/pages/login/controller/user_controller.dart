import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wanandroid/api/api_service.dart';
import 'package:my_wanandroid/base/base_controller.dart';
import 'package:my_wanandroid/http/base_result.dart';
import 'package:my_wanandroid/model/user_info.dart';
import 'package:my_wanandroid/routes/route_utils.dart';
import 'package:my_wanandroid/utils/loading_dialog_util.dart';
import 'package:my_wanandroid/utils/storage_util.dart';
import 'package:my_wanandroid/utils/toast_util.dart';

class UserController extends BaseController<UserInfo> {
  final Rx<UserInfo> _userInfo = UserInfo().obs;

  UserInfo get userInfo => _userInfo.value;

  //更新用户信息
  set userInfo(UserInfo value) => _userInfo.value = value;

  bool get isLogin =>
      _userInfo.value.username.isEmpty && _userInfo.value.id != 0;
  @override
  Future<void> loadData() async {}

  Future<void> login(String username, String password) async {
    try {
      await LoadingDialogUtil.showDuring<BaseResult<UserInfo>>(
        Get.context!,
        () async {
          final currentUserInfo = await ApiService().login(
            params: {"username": username, "password": password},
          );
          if (currentUserInfo.isSuccess) {
            ToastUtil.show('登陆成功，欢迎回来，$username!');
            //记住密码
            StorageUtil.setString(StorageKey.loginUsername, username);
            StorageUtil.setString(StorageKey.loginPassword, password);
            // userInfo = currentUserInfo.data!;
            //更新用户信息
            _userInfo.value = currentUserInfo.data!;
            RouteUtils.back();
          } else {
            ToastUtil.showError(currentUserInfo.errorMsg);
          }
          return currentUserInfo;
        },
      );
    } catch (e) {
      ToastUtil.show(e.toString());
    }
  }
}
