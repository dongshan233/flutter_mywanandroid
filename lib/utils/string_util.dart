class StringUtil {
  static String removeMdash(String str) {
    return str.replaceAll(RegExp(r'&mdash;'), '');
  }

  static String removeHarmonyosDevPrefix(String str) {
    return str.replaceAll('鸿蒙开发', '鸿蒙');
  }
}
