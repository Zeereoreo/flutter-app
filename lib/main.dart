
import 'dart:convert';

import 'package:deego_client/home.dart';
import 'package:deego_client/login.dart';
import 'package:flutter/material.dart';
import 'package:deego_client/point.dart';
import 'package:deego_client/map.dart';
import 'package:deego_client/setting.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


void main () async {
  KakaoSdk.init(nativeAppKey: '413db6c1481faf48ecd19af7a9b474e4');
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: '02pij2jc6t');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String accessToken = "";

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthStore(accessToken)),
        ChangeNotifierProvider(create: (context) => pointStore()),
        ChangeNotifierProvider(create: (context) => userStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        routes: {
          "/" : (context) => Home(accessToken: accessToken),
          "/map" :(context) => const NaverMapApp(),
          "/point" :(context) => Point(accessToken: accessToken),
          "/setting" :(context) => const Setting(),
          "/login" : (context) => const Log(),
        },
      ),
    );
  }
}

class AuthStore extends ChangeNotifier{
  String _accessToken;

  AuthStore(this._accessToken);

  String get accessToken => _accessToken;

  set accessToken(String newToken) {
    _accessToken = newToken;
    notifyListeners();
    print("엑세스토큰 $accessToken");
  }
}

class userStore extends ChangeNotifier{
  var id = "";
  var name = "";
  var phone = "";
  var email = "";

  notifyListeners();

}

class pointStore extends ChangeNotifier{
  var incomes = 0;
  var spents = 0;
  var current = 0;

    notifyListeners();


}






