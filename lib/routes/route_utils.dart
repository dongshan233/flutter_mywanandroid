import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteUtils {
  // 构造方法私有化
  RouteUtils._();

  // 跳转页面（带返回值）
  static Future<T?> to<T>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
    bool preventDuplicates = true,
    Transition? transition,
    Duration? duration,
  }) async {
    try {
      return await Get.toNamed<T>(
        route,
        arguments: arguments,
        parameters: parameters,
        preventDuplicates: preventDuplicates,
      );
    } catch (e) {
      Get.snackbar('导航错误', '无法跳转到 $route: $e');
      return null;
    }
  }

  //跳转并替换当前页面
  static Future<T?> off<T>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
    bool preventDuplicates = true,
  }) async {
    try {
      return await Get.offNamed<T>(
        route,
        arguments: arguments,
        parameters: parameters,
        preventDuplicates: preventDuplicates,
      );
    } catch (e) {
      Get.snackbar('导航错误', '无法跳转到 $route: $e');
      return null;
    }
  }

  //跳转并关闭所有页面
  Future<T?> offAll<T>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) async {
    try {
      return await Get.offAllNamed<T>(
        route,
        arguments: arguments,
        parameters: parameters,
      );
    } catch (e) {
      Get.snackbar('导航错误', '无法跳转到 $route: $e');
      return null;
    }
  }

  //返回上一页
  static void back<T>({T? result}) {
    try {
      //判断是否可以返回
      bool canPop = Get.key.currentState?.canPop() ?? false;
      if (canPop) {
        Get.back<T>(result: result);
      } else {
        Get.snackbar('导航错误', '无法返回上一页: 当前没有可返回的页面');
      }
    } catch (e) {
      Get.snackbar('导航错误', '无法返回上一页: $e');
    }
  }

  //返回指定页面
  static void backUntil(String route) {
    try {
      // ignore: unrelated_type_equality_checks
      Get.until((route) => route.settings.name == route);
    } catch (e) {
      Get.snackbar('导航错误', '无法返回到指定页面 $route: $e');
    }
  }

  static void backToRoot() {
    try {
      Get.until((route) => route.isFirst);
    } catch (e) {
      Get.snackbar('导航错误', '无法返回到根页面: $e');
    }
  }

  static Future<T?> popAndPush<T>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) async {
    try {
      return await Get.offNamed<T>(
        route,
        arguments: arguments,
        parameters: parameters,
      );
    } catch (e) {
      Get.snackbar('导航错误', '无法跳转到 $route: $e');
      return null;
    }
  }

  //获取路由参数
  static T? getArgument<T>() {
    try {
      return Get.arguments as T?;
    } catch (e) {
      Get.snackbar('导航错误', '无法获取参数: $e');
      return null;
    }
  } //获取路由参数（带类型安全）

  static T? getParameter<T>(String key) {
    try {
      return Get.parameters[key] as T?;
    } catch (e) {
      Get.snackbar('导航错误', '无法获取参数: $e');
      return null;
    }
  }

  static String? getCurrentRoute() {
    try {
      return Get.currentRoute;
    } catch (e) {
      Get.snackbar('导航错误', '无法获取当前路由: $e');
      return null;
    }
  }

  static bool canPop() {
    try {
      return Get.key.currentState?.canPop() ?? false;
    } catch (e) {
      Get.snackbar('导航错误', '无法判断是否可以返回上一页: $e');
      return false;
    }
  }
}
