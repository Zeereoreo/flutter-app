import 'package:http/http.dart' as http;
import 'dart:convert';

class SnsApiService {
  static const String baseUrl = 'https://test.deegolabs.com:3000/mobile/auth/sns';

  Future<void> sendTokenToServer(String snsType, String snsToken) async {
    final String url = '$baseUrl/$snsType/$snsToken';
    print("url: $url");
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        // You can add more headers or customize the request as needed.

        // Example payload (you might need to customize it based on your server's requirements):
        // 'data': jsonEncode({
        //   'token': snsToken,
        //   // Add more fields as needed
        // }),
      );

      if (response.statusCode == 200) {
        // Successful request
        print('Token sent successfully');
        print('Response: ${response.body}');
      } else {
        // Request failed
        print('Failed to send token. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      // Exception during the request
      print('Error during the request: $error');
    }
  }
}
