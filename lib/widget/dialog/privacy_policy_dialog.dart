import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:my_wanandroid/routes/route_utils.dart';
import 'package:my_wanandroid/utils/storage_util.dart';
import 'package:my_wanandroid/utils/toast_util.dart';

class PrivacyPolicyDialog {
  static const String _agreedKey = 'privacy_policy_agreed';

  static bool hasAgreed() {
    try {
      return StorageUtil.getBool(_agreedKey) ?? false;
    } catch (e) {
      return false; // Default to false if there's an error
    }
  }

  static Future<void> _saveAgreed(bool agreed) async {
    try {
      await StorageUtil.setBool(_agreedKey, agreed);
    } catch (e) {
      // Handle error if needed
      ToastUtil.show('保存状态失败: $e');
    }
  }

  static Future<void> show({
    Function()? onAgree,
    Function()? onDisagree,
  }) async {
    try {
      await Get.dialog(
        transitionCurve: Curves.easeInOut,
        transitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: false,
        _PrivacyPolicyContent(
          onAgree: () async {
            await _saveAgreed(true);
            debugPrint("hasAgreed:onAgree:${hasAgreed()}");
            Get.back();
          },
          onDisagree: () async {
            await _saveAgreed(false);
            Get.back();
          },
        ),
      );
      debugPrint("hasAgreed:${hasAgreed()}");
      //检查用户是否同意
      if (hasAgreed()) {
        onAgree?.call();
      } else {
        onDisagree?.call() ?? _defaultDisagreeAction();
      }
    } catch (e) {
      ToastUtil.show('显示隐私政策对话框失败: $e');
    }
  }

  static void _defaultDisagreeAction() {
    ToastUtil.show('同意政策以使用应用');
    Future.delayed(const Duration(seconds: 1), () {});
  }
}

class _PrivacyPolicyContent extends StatefulWidget {
  final VoidCallback? onAgree;
  final VoidCallback? onDisagree;
  const _PrivacyPolicyContent({
    required this.onAgree,
    required this.onDisagree,
  });

  @override
  State<_PrivacyPolicyContent> createState() => __PrivacyPolicyContentState();
}

class __PrivacyPolicyContentState extends State<_PrivacyPolicyContent> {
  bool _isAgreed = true;
  @override
  void initState() {
    super.initState();
    PrivacyPolicyDialog._saveAgreed(_isAgreed);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 20.0),
                  _buildContent(context),
                  const SizedBox(height: 10.0),

                  const SizedBox(height: 24.0),
                  _buildButtons(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '隐私政策',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
                height: 1.6,
              ),
              children: [
                const TextSpan(text: '欢迎使用WanAndroid应用程序！\n'),
                const TextSpan(text: '我们非常重视您的隐私和个人信息的保护。您可以通过'),
                _buildLinkText('《隐私政策》'),
                const TextSpan(text: '和'),
                _buildLinkText('《用户协议》'),
                const TextSpan(
                  text:
                      '了解我们收集、使用、存储用户个人信息的情况，以及您所享有的相关权利。\n请您仔细阅读并充分理解相关内容：\n1.为向您提供游戏服务，我们将依据',
                ),
                _buildLinkText('《隐私政策》'),
                const TextSpan(text: '收集、使用、存储必要的信息。'),
                const TextSpan(
                  text: '\n2. 基于您的明示授权，我们可能会申请开启您的设备权限，您有权拒绝或取消授权。',
                ),
                const TextSpan(text: '\n3. 我们会采取业界先进的安全措施保护您的信息安全。'),
                const TextSpan(text: '\n4. 未经您同意，我们不会从第三方处获取、共享或向其提供您的信息。'),
                const TextSpan(text: '\n5. 您可以查询、更正、删除您的个人信息，我们也提供账号注销的渠道。'),
                const TextSpan(text: '\n\n'),
                const TextSpan(text: '请您认真阅读上述协议内容。如果您同意，请勾选下方选项并点击"同意"按钮。'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextSpan _buildLinkText(String text) {
    return TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          // Handle link tap, e.g., ope
          ToastUtil.show('点击了: $text');
        },
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: _buildButton(
              text: '不同意',
              isPrimary: false,
              onTap: () => {widget.onDisagree},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildButton(
              text: '同意',
              isPrimary: true,
              onTap: widget.onAgree,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required bool isPrimary,
    Function()? onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: onTap != null
            ? (isPrimary ? Colors.red : Colors.grey.shade100)
            : Colors.grey.shade200,
        foregroundColor: onTap != null
            ? (isPrimary ? Colors.white : Colors.black87)
            : Colors.grey.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        minimumSize: const Size(double.infinity, 45),
        elevation: 0,
        side: isPrimary ? null : BorderSide(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
