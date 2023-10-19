import 'package:http/http.dart' as http;

class Domain {
  final String _baseUrl = "https://newtonbreakoutrevival.onrender.com/";
  static const Map<String, String> defaultheader = {
    'Content-Type': 'application/json',
  };

  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse("$_baseUrl$endpoint");
    final response = await http.get(
      url,
      headers: defaultheader,
    );
    return response;
  }

  Future<dynamic> post(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    final url = Uri.parse("$_baseUrl$endpoint");
    final response = await http.post(
      url,
      body: body,
      headers: defaultheader,
    );
    return response;
  }
}
