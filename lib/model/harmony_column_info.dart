class HarmonyColumn {
  HarmonyosColumnLinks links;
  HarmonyosColumnOpenSources open_sources;
  HarmonyosColumnTools tools;
  HarmonyColumn({
    required this.links,
    required this.open_sources,
    required this.tools,
  });

  factory HarmonyColumn.fromJson(Map<String, dynamic> json) {
    return HarmonyColumn(
      links: HarmonyosColumnLinks.fromJson(json['links']),
      open_sources: HarmonyosColumnOpenSources.fromMap(json['open_sources']),
      tools: HarmonyosColumnTools.fromMap(json['tools']),
    );
  }
}

class HarmonyosColumnLinks {
  int id;
  String name;
  String link;
  List<HarmonyosColumnArticle> articleList = [];
  HarmonyosColumnLinks({
    required this.id,
    required this.name,
    required this.link,
    required this.articleList,
  });
  factory HarmonyosColumnLinks.fromJson(Map<String, dynamic> json) {
    return HarmonyosColumnLinks(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      articleList: (json['articleList'] as List)
          .map(
            (e) => HarmonyosColumnArticle.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class HarmonyosColumnArticle {
  int audit;
  String author;
  bool collect;
  int id;
  String chapterName;
  String desc;
  String superChapterName;
  String niceDate;
  String link;
  //构造函数
  HarmonyosColumnArticle({
    required this.audit,
    required this.author,
    required this.collect,
    required this.id,
    required this.chapterName,
    required this.desc,
    required this.superChapterName,
    required this.niceDate,
    required this.link,
  });

  factory HarmonyosColumnArticle.fromJson(Map<String, dynamic> json) {
    return HarmonyosColumnArticle(
      audit: json['audit'] ?? '',
      author: json['author'] ?? '',
      collect: json['collect'] ?? false,
      id: json['id'] ?? 0,
      chapterName: json['chapterName'] ?? '',
      desc: json['desc'] ?? '',
      superChapterName: json['superChapterName'] ?? '',
      niceDate: json['niceDate'] ?? '',
      link: json['link'] ?? '',
    );
  }
}

class HarmonyosColumnOpenSources {
  int id;
  String name;
  List<HarmonyosColumnArticle> articleList = [];
  HarmonyosColumnOpenSources({
    required this.id,
    required this.name,
    required this.articleList,
  });

  factory HarmonyosColumnOpenSources.fromMap(Map<String, dynamic> json) {
    return HarmonyosColumnOpenSources(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      articleList: (json['articleList'] as List)
          .map(
            (e) => HarmonyosColumnArticle.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class HarmonyosColumnTools {
  int id;
  String name;
  List<HarmonyosColumnArticle> articleList = [];
  HarmonyosColumnTools({
    required this.id,
    required this.name,
    required this.articleList,
  });

  factory HarmonyosColumnTools.fromMap(Map<String, dynamic> json) {
    return HarmonyosColumnTools(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      articleList: (json['articleList'] as List)
          .map(
            (e) => HarmonyosColumnArticle.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
