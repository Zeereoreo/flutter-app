import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'main.dart';

class SnsApiService {
  static const String baseUrl = 'https://test.deegolabs.kr/mobile/auth/sns';
  final storage = FlutterSecureStorage();


  Future<void> sendTokenToServer(BuildContext context, String snsType, String snsToken) async {
    final String url = '$baseUrl/$snsType/$snsToken';
    print("url: $url");
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        // headers: <String, String>{
        //   'Content-Type': 'application/json',
        // },
      );
      print("유알엘 : ${Uri.parse(url)}");
      print("리스폰스 ${response.body}");
      if (response.statusCode == 200) {
        // Successful request
        print('Token sent successfully');
        print('Response: ${response.body}');
        var result = json.decode(response.body);
        context.read<AuthStore>().accessToken = result["userSNS"]["accessToken"];
        context.read<userStore>().name = result["userSNS"]["user"]["name"];
        print("${result["userSNS"]["accessToken"]}");
        await storage.write(key: 'login', value: result["userSNS"]["accessToken"]);
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
