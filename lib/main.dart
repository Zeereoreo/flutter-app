
import 'dart:convert';
import 'dart:io';

import 'package:deego_client/home.dart';
import 'package:deego_client/login.dart';
import 'package:flutter/material.dart';
import 'package:deego_client/point.dart';
import 'package:deego_client/map.dart';
import 'package:deego_client/setting.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

ThemeData initThemeData(){
  return ThemeData(

  );
}
TextTheme textTheme(Color textColor) {
  return TextTheme(
    displayLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold,fontSize: 24),
    displayMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold,fontSize: 20),
    displaySmall: TextStyle(color: textColor, fontWeight: FontWeight.bold,fontSize: 16),
  );
}

AppBar appBarTheme(BuildContext context, String title, bool backButton) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0.0,
    leading: backButton ? IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.black,
      onPressed: () {
        Navigator.of(context).pop();
      },
    ) : null,
  );
}


void main () async {
  KakaoSdk.init(nativeAppKey: '413db6c1481faf48ecd19af7a9b474e4');
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: '02pij2jc6t',onAuthFailed: (ex) {
    print("********* 네이버맵 인증오류 : $ex *********");
  });
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String accessToken = "";
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black; // 예시로 텍스트 색상을 검정색으로 설정
    TextTheme customTextTheme = textTheme(textColor); // 텍스트 테마 초기화
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthStore(accessToken)),
        ChangeNotifierProvider(create: (context) => pointStore()),
        ChangeNotifierProvider(create: (context) => userStore()),
        ChangeNotifierProvider(create: (context) => footerStore()),
        ChangeNotifierProvider(create: (context) => phoneUUIDStroe()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: customTextTheme, // 커스텀 텍스트 테마 적용
        ),
        routes: {
          "/" : (context) => Home(accessToken: accessToken),
          "/map" :(context) =>  NaverMapApp(),
          "/point" :(context) => Point(accessToken: accessToken),
          "/setting" :(context) =>  Setting(),
          "/login" : (context) =>  Log(),
        },
        // home: Scaffold(
        //   // appBar: Header(),
        //   body: [Home(accessToken: accessToken),NaverMapApp(),Point(accessToken: accessToken),Setting()][tab],
        //   bottomNavigationBar: BottomMenu(),
        // ),
      ),
    );
  }
}

class AuthStore extends ChangeNotifier{
  String _accessToken;
  var refreshToken;

  AuthStore(this._accessToken);

  String get accessToken => _accessToken;

  set accessToken(String newToken) {
    _accessToken = newToken;
    notifyListeners();
    print("엑세스토큰 $accessToken");
  }

  notifyListeners();
}

class userStore extends ChangeNotifier{
  var id = "";
  var name = "";
  var phone = "";
  var email = "";

  notifyListeners();

}

class phoneUUIDStroe extends ChangeNotifier{
  var phoneUUID = "";

  notifyListeners();

}

class pointStore extends ChangeNotifier{
  var incomes = 0;
  var spents = 0;
  var current = 0;

    notifyListeners();
}

class footerStore extends ChangeNotifier{
  var tab = 0;

  notifyListeners();
}






