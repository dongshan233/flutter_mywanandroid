class UserInfo {
  bool admin = false;
  int coinCount = 0;
  String email = '';
  String icon = '';
  int id = 0;
  String nickname = '';
  String password = '';
  String publicName = '';
  String token = '';
  int type = 0;
  String username = '';

  //默认构造函数
  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo()
      ..admin = json['admin']
      ..coinCount = json['coinCount']
      ..email = json['email']
      ..icon = json['icon']
      ..id = json['id']
      ..nickname = json['nickname']
      ..password = json['password']
      ..publicName = json['publicName']
      ..token = json['token']
      ..type = json['type']
      ..username = json['username'];
  }
}
