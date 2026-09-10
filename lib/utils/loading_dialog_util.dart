import 'package:flutter/material.dart';
import 'package:my_wanandroid/widget/loading_widget.dart';

class LoadingDialogUtil {
  //显示加载对话框
  // [context] 上下文
  //@param backgroundColor 背景色
  //barrierDismissible 点击空白背景是否可关闭
  static void show(
    BuildContext context, {
    Color backgroundColor = Colors.white,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black54,
      builder: (context) {
        return PopScope(
          canPop: barrierDismissible,
          child: Center(
            child: SizedBox(
              height: 110,
              width: 110,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LoadingWidget(backgroundColor: backgroundColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Future<T?> showDuring<T>(
    BuildContext context,
    Future<T> Function() task, {
    Color backgroundColor = Colors.white,
    bool barrierDismissible = false,
  }) async {
    show(
      context,
      backgroundColor: backgroundColor,
      barrierDismissible: barrierDismissible,
    );
    try {
      final result = await task();
      return result;
    } finally {
      hide(context);
    }
  }
}
