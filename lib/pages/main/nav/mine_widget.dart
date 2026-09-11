import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:my_wanandroid/pages/login/controller/user_controller.dart';
import 'package:my_wanandroid/routes/route_utils.dart';
import 'package:my_wanandroid/routes/routes.dart';
import 'package:my_wanandroid/widget/dialog/login_out_dialog.dart';

class MineWddget extends StatefulWidget {
  const MineWddget({super.key});

  @override
  State<MineWddget> createState() => _MineWddgetState();
}

class _MineWddgetState extends State<MineWddget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late final UserController _userController;
  @override
  void initState() {
    super.initState();
    _userController = Get.find<UserController>();
  }

  final List<MenuItem> _menuItemsGroup1 = [
    MenuItem(
      icon: Icons.favorite_outline,
      title: '收藏夹',
      badge: '12',
      onTap: () {},
    ),
    MenuItem(icon: Icons.history_outlined, title: '浏览历史', onTap: () {}),
    MenuItem(icon: Icons.star_outline, title: '积分', badge: '256', onTap: () {}),
  ];
  final List<MenuItem> _menuItemsGroup2 = [
    MenuItem(icon: Icons.settings_outlined, title: '设置', onTap: () {}),
    MenuItem(icon: Icons.help_outline, title: '帮助与反馈', onTap: () {}),
    MenuItem(icon: Icons.info_outline, title: '关于我们', onTap: () {}),
  ];
  // 功能菜单列表 - 第三组
  final List<MenuItem> _menuItemsGroup3 = [
    MenuItem(
      icon: Icons.notifications_outlined,
      title: '我的消息',
      onTap: () {
        // 跳转到消息页面
      },
    ),
    MenuItem(
      icon: Icons.local_activity_outlined,
      title: '我的活动',
      onTap: () {
        // 跳转到活动页面
      },
    ),
    MenuItem(
      icon: Icons.privacy_tip_outlined,
      title: '隐私设置',
      onTap: () {
        // 跳转到隐私设置页面
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true, //滑动到顶部固定住
            expandedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(vertical: 10),
              background: Obx(() {
                return _userController.userInfo.id != 0
                    ? Image.network(
                        "https://img0.baidu.com/it/u=317835332,3557759002&fm=253&fmt=auto&app=120&f=JPEG?w=1333&h=800",
                        fit: BoxFit.cover,
                        height: 240,
                      )
                    : Image.asset(
                        'assets/images/ic_mine_header_bg.png',
                        height: 240,
                        fit: BoxFit.cover,
                      );
              }),
              title: GestureDetector(
                onTap: () {
                  if (!_userController.isLogin) {
                    RouteUtils.to(Routes.login);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20, left: 16),
                  child: Obx(() {
                    final userInfo = _userController.userInfo;
                    final username = userInfo.username.isNotEmpty
                        ? userInfo.username
                        : '点击登录|注册';
                    final avatarUrl = userInfo.icon;
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: avatarUrl.isNotEmpty
                              ? Image.network(
                                  avatarUrl,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/ic_logo.png',
                                  height: 40,
                                  width: 40,
                                ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildStatesSection(),
                _buildMenuSection(_menuItemsGroup1),
                const SizedBox(height: 16),
                _buildMenuSection(_menuItemsGroup2),
                const SizedBox(height: 16),
                _buildMenuSection(_menuItemsGroup3),
                const SizedBox(height: 26),
                Obx(() {
                  debugPrint('isLogin::${_userController.isLogin}');
                  if (_userController.isLogin) {
                    return _buildLogoutButton();
                  }
                  return SizedBox.shrink();
                }),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatesSection() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStateItem('关注', '45'),
          const VerticalDivider(width: 1, color: Color(0xFFF0F0F0)),
          _buildStateItem('粉丝', '145'),
          VerticalDivider(width: 1, color: Color(0xFFF0F0F0)),
          _buildStateItem('文章', '5'),
          VerticalDivider(width: 1, color: Color(0xFFF0F0F0)),
        ],
      ),
    );
  }

  Widget _buildStateItem(String title, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMenuSection(List<MenuItem> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        //asMap ,可以将list转成map，从而获取item的index ，asMap->(key,item); map只能获得item获取不到是第几个
        children: items.asMap().entries.map((entry) {
          int index = entry.key;
          MenuItem item = entry.value;
          return Column(
            children: [
              InkWell(
                onTap: item.onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      Icon(item.icon, size: 24, color: Color(0xFF667eea)),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                      if (item.badge != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            item.badge!,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      SizedBox(width: 8),
                      Icon(Icons.chevron_right, size: 24, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              if (index < items.length - 1)
                const Divider(height: 1, indent: 60, color: Color(0xFFF0F0F0)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          LoginOutDialog.show();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(double.infinity, 50),
          elevation: 0,
          side: const BorderSide(color: Colors.red, width: 1),
        ),
        child: Text(
          '退出登录',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  final String? badge;
  final Function() onTap;
  MenuItem({
    required this.icon,
    required this.title,
    this.badge,
    required this.onTap,
  });
}
