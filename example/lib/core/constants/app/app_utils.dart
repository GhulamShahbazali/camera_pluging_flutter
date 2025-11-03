class AppUtils {
  static String? stripPrefix(String? dataUrl) {
    if (dataUrl == null) return null;
    final idx = dataUrl.indexOf('base64,');
    return idx != -1 ? dataUrl.substring(idx + 7) : dataUrl;
  }
}
