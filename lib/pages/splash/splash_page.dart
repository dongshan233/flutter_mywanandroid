import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_wanandroid/routes/route_utils.dart';
import 'package:my_wanandroid/routes/routes.dart';
import 'package:my_wanandroid/widget/dialog/privacy_policy_dialog.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _initAnimations();
    //延时一秒显示
    Future.delayed(const Duration(seconds: 1), () {
      //Widget完成构建后再显示
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showPrivacyPolicyDialog();
        }
      });
    });
  }

  void showPrivacyPolicyDialog() {
    if (!PrivacyPolicyDialog.hasAgreed()) {
      PrivacyPolicyDialog.show(
        onAgree: () async {
          // Handle agree action
          _navigateToMain();
        },
        onDisagree: () async {
          // Handle disagree action
          SystemNavigator.pop();
        },
      );
    } else {
      //跳转主页 // User has already agreed, proceed with the app flow
      _navigateToMain();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 32),
                    _buildAppName(),
                    const SizedBox(height: 48),
                    _buildLoadingIndicator(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToMain() {
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        RouteUtils.off(Routes.home); // Navigate to the main page
      }
    });
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFf0f0f0),
        borderRadius: BorderRadius.circular(60),
      ),
      child: ClipOval(
        child: Image.asset('assets/images/ic_logo.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildAppName() {
    return const Column(
      children: [
        Text(
          'WanAndroid',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '玩安卓客户端',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF61c7fe),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0077f1)),
        backgroundColor: Color(0xFFf0f0f0),
      ),
    );
  }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }
}
