import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:my_wanandroid/pages/login/controller/user_controller.dart';
import 'package:my_wanandroid/utils/storage_util.dart';

class LoginPag extends StatefulWidget {
  const LoginPag({super.key});

  @override
  State<LoginPag> createState() => _LoginPagState();
}

class _LoginPagState extends State<LoginPag>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  UserController _userController = Get.find<UserController>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _rememberPassword = false;
  bool _obscurePassword = true;

  String _usernameError = '';
  String _passwordError = '';

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
    if (_rememberPassword) {
      String currentUsername =
          StorageUtil.getString(StorageKey.loginUsername) ?? '';
      String currentPassword =
          StorageUtil.getString(StorageKey.loginPassword) ?? '';
      if (currentUsername.isNotEmpty && currentPassword.isNotEmpty) {
        _usernameController.text = currentUsername;
        _passwordController.text = currentPassword;
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
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

  Widget _buildUsernameField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: _usernameError.isNotEmpty ? Colors.red : Colors.green[200]!,
        ),
      ),
      child: TextField(
        controller: _usernameController,
        onChanged: (value) {
          setState(() {
            _usernameError = '';
          });
        },
        decoration: InputDecoration(
          hintText: '请输入用户名',
          prefixIcon: Icon(Icons.person, color: Color(0xff999999)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
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
                  children: [
                    const SizedBox(height: 60),
                    _buildLogo(),
                    SizedBox(height: 50),
                    _buildUsernameField(),
                    if (_usernameError.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _usernameError,
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    _buildPasswordField(),
                    if (_passwordError.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _passwordError,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    _buildForgotPassword(),
                    const SizedBox(height: 30),
                    _buildButtons(),
                    SizedBox(height: 20),
                    _buildRegisterLink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(
              fillColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? Color(0xFF0077f1)
                    : Colors.grey[200]!,
              ),
              value: _rememberPassword,
              onChanged: (isSelect) {
                StorageUtil.setBool(
                  StorageKey.loginRememberPassword,
                  isSelect ?? false,
                );
                setState(() {
                  _rememberPassword = isSelect ?? false;
                });
              },
            ),
            Text(
              '记住密码',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ],
        ),

        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              '忘记密码',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: _passwordError.isNotEmpty ? Colors.red : Colors.green[200]!,
        ),
      ),
      child: TextField(
        controller: _passwordController,
        onChanged: (value) {
          setState(() {
            _passwordError = '';
          });
        },
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          hintText: '请输入密码',
          prefixIcon: Icon(Icons.lock, color: Color(0xFF999999)),

          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            color: Color(0xFF999999),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF0077f1), Color(0xFF0077f1)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0077f1).withValues(alpha: 0.4),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: _handleLogin,
        child: Text(
          '登录',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    setState(() {
      _usernameError = '';
      _passwordError = '';
    });

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    var isValid = true;
    if (username.isEmpty) {
      setState(() {
        _usernameError = '请输入用户名';
      });
      isValid = false;
    }
    if (password.isEmpty) {
      setState(() {
        _passwordError = '请输入密码';
      });
      isValid = false;
    } else if (password.length < 6) {
      setState(() {
        _passwordError = '密码长度小于6位';
      });
      isValid = false;
    }
    if (isValid) {
      await _userController.login(username, password);
    }
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('还没有账号？', style: TextStyle(fontSize: 15, color: Colors.grey[600])),
        TextButton(
          onPressed: () {},
          child: Text(
            '立即注册',
            style: TextStyle(
              color: Color(0xFF0077f1),
              fontSize: 15,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
