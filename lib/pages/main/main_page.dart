import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_wanandroid/pages/main/nav/harmonyos_column.dart';
import 'package:my_wanandroid/pages/main/nav/home_widget.dart';
import 'package:my_wanandroid/pages/main/nav/mine_widget.dart';
import 'package:my_wanandroid/pages/main/nav/project_menu_widget.dart';
import 'package:my_wanandroid/pages/main/nav/system_widget.dart';
import 'package:my_wanandroid/widget/double_back_exit_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<BottomNavigationBarItem> _items() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
      BottomNavigationBarItem(icon: Icon(Icons.article), label: '鸿蒙'),
      BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: '体系'),
      BottomNavigationBarItem(icon: Icon(Icons.menu), label: '项目'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackExitWidget(
      onDoubleBack: () {
        SystemNavigator.pop();
      },
      onSingleBack: () {
        // Handle single back press (e.g., show a toast message)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('再按一次退出应用')));
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeWidget(),
            HarmonyosColumn(),
            SystemWidget(),
            ProjectMenuWidget(),
            MineWddget(),
          ],
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _items(),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF0077f1),
          unselectedItemColor: Color(0xFF999999),
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(_currentIndex);
            });
          },
        ),
      ),
    );
  }
}
