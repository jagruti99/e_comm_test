import 'dart:convert';
import 'dart:io';

class ApiClient {
  static const _base = 'https://api-dev.zwara.co/api/v1';
  final HttpClient _http =
      HttpClient()..connectionTimeout = const Duration(seconds: 15);

  Future<Map<String, dynamic>> get(String pathWithQuery) async {
    final uri = Uri.parse('$_base/$pathWithQuery');
    try {
      final req = await _http.getUrl(uri);
      final res = await req.close();
      final body = await res.transform(utf8.decoder).join();
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return jsonDecode(body) as Map<String, dynamic>;
      }
      throw HttpException('HTTP ${res.statusCode}: $body', uri: uri);
    } on SocketException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> post(
    String pathWithQuery,
    Map<String, dynamic> bodyJson,
  ) async {
    final uri = Uri.parse('$_base/$pathWithQuery');
    try {
      final req = await _http.postUrl(uri);
      req.headers.contentType = ContentType.json;
      req.write(jsonEncode(bodyJson));
      final res = await req.close();
      final body = await res.transform(utf8.decoder).join();
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return jsonDecode(body) as Map<String, dynamic>;
      }
      throw HttpException('HTTP ${res.statusCode}: $body', uri: uri);
    } on SocketException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
