import 'dart:convert';
import 'package:http/http.dart' as http;

class PexelsService {
  // Free Pexels API key (or placeholder/user key).
  static const String _apiKey = '563492ad6f91700001000001bc9c4f74d0a9446d849a9ba46d841e2a';

  static Future<String> fetchImage(String query, String fallbackUrl) async {
    try {
      final url = Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=1');
      final response = await http.get(url, headers: {
        'Authorization': _apiKey,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.statusCode == 200 ? response.body : '');
        final photos = data['photos'] as List;
        if (photos.isNotEmpty) {
          return photos[0]['src']['medium'] as String;
        }
      }
    } catch (_) {
      // Fallback on any error
    }
    return fallbackUrl;
  }
}
