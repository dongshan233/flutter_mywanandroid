import 'package:get/get.dart';
import 'package:my_wanandroid/pages/main/main_page.dart';
import 'package:my_wanandroid/pages/splash/splash_page.dart';

class Routes {
  static const String initial = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String webView = '/webview';

  static final List<GetPage> pages = [
    GetPage(
      name: initial,
      page: () => const SplashPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: home, page: () => const MainPage()),
    // GetPage(name: login, page: () => const LoginPage()),
    // GetPage(name: register, page: () => const RegisterPage()),
    // GetPage(name: webView, page: () => const WebViewPage()),
  ];
}
