import 'package:deego_client/home.dart';
import 'package:deego_client/login.dart';
import 'package:flutter/material.dart';
import 'package:deego_client/point.dart';
import 'package:deego_client/map.dart';
import 'package:deego_client/setting.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';


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
  // int tap = 0; // tap 상태는 클래스 멤버 변수로 선언해야 합니다
  //
  // final List<Widget> pages = [
  //   Home(),
  //   NaverMapApp(),
  //   Point(),
  //   Setting(),
  // ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/" : (context) => const Home(),
        "/map" :(context) => const NaverMapApp(),
        "/point" :(context) => const Point(),
        "/setting" :(context) => const Setting(),
        "/login" : (context) => const Log(),
      },
       // home: Scaffold(
       //  body: IndexedStack(
       //    index: tap,
       //    children: pages,
       //  ),
       //  bottomNavigationBar: BottomNavigationBar(
       //    showUnselectedLabels: true,
       //    selectedItemColor: Colors.black,
       //    unselectedItemColor: Colors.grey,
       //    onTap: (i) {
       //      setState(() {
       //        tap = i;
       //      });
       //    },
       //    items: const [
       //      BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: '홈'),
       //      BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: '디고찾기'),
       //      BottomNavigationBarItem(icon: Icon(Icons.store_rounded), label: '포인트'),
       //      BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
       //    ],
       //  ),
      // ),
    );
  }
}






