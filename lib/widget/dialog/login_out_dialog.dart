import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

class LoginOutDialog {
  static Future<void> show({
    String title = '退出登录',
    String content = '确定要退出登录吗？',
    String confirmText = '确认退出？',
    String cancelText = '取消',
    Function()? onConfirm,
  }) async {
    await Get.dialog(
      _buildDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm ?? _defaultLogout,
      ),
      barrierDismissible: false,
    );
  }

  static Widget _buildDialog({
    required String title,
    required String content,
    required String confirmText,
    required String cancelText,
    required Function() onConfirm,
  }) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _buildButton(
                    text: '取消',
                    isPrimary: false,
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildButton(
                    text: '确认',
                    isPrimary: true,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildButton({
    required String text,
    required bool isPrimary,
    required Function() onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.red : Colors.grey.shade100,
        foregroundColor: isPrimary ? Colors.white : Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        minimumSize: Size(double.infinity, 44),
        elevation: 0,
        side: isPrimary ? null : BorderSide(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  static Future<void> _defaultLogout() async {}
}
