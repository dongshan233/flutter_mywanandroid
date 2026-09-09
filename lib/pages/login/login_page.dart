import 'package:flutter/material.dart';
import 'package:my_wanandroid/utils/storage_util.dart';

class LoginPag extends StatefulWidget {
  const LoginPag({super.key});

  @override
  State<LoginPag> createState() => _LoginPagState();
}

class _LoginPagState extends State<LoginPag>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _rememberPassword = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _animationController.forward();

    _rememberPassword =
        StorageUtil.getBool(StorageKey.loginRememberPassword) ?? false;
    if (_rememberPassword) {}
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [Colors.white, Color(0xFFf0f0f0)],
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset('assets/images/ic_logo.png'),
          ),
        ),

        const SizedBox(height: 20),
        const Text(
          '智康中医',
          style: TextStyle(
            fontSize: 28,
            color: Color(0xFF0077F1),
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '登陆您的帐户',
          style: TextStyle(fontSize: 16, color: Color(0xFF999999)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录'), centerTitle: true),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [const SizedBox(height: 60), _buildLogo()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
