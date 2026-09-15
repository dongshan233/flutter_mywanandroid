class SystemTreeInfo {
  final int id;
  final String name;
  final List<SystemTreeItem> children;

  SystemTreeInfo({
    required this.id,
    required this.name,
    required this.children,
  });

  factory SystemTreeInfo.fromMap(Map<String, dynamic> json) {
    return SystemTreeInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      children: (json['children'] as List)
          .map((e) => SystemTreeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SystemTreeItem {
  final int id;
  final String name;
  SystemTreeItem({required this.id, required this.name});

  factory SystemTreeItem.fromJson(Map<String, dynamic> json) {
    return SystemTreeItem(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}
