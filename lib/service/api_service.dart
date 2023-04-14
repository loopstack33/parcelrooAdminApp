import 'package:http/http.dart' as http;
/* -------- 14-Apr-2023 -------- */
class ApiService {

  //IP ADDRESS API
  Future<http.Response> getIP() async {
    final response = await http.get(
      Uri.parse('https://geoip.maxmind.com/geoip/v2.1/city/me'),
      headers: {
        'Host': "geoip.maxmind.com",
        "Content-Type":
        "application/vnd.maxmind.com-city+json; charset=UTF-8; version=2.1",
        "Authorization": "Basic ODM3ODUwOmp2MUNyZFFMelJ3empvWmk="
      },
    );
    return response;
  }
}