import 'package:deego_client/home.dart';
import 'package:deego_client/login.dart';
import 'package:deego_client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'login_platform.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}


class _HeaderState extends State<Header> {

  LoginPlatform _loginPlatform = LoginPlatform.none;

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Log()));
        break;
      case LoginPlatform.naver:
        await FlutterNaverLogin.logOut();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Log()));
        break;
      case LoginPlatform.none:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Log()));
        break;
    }
    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
    var a = await UserApi.instance.accessTokenInfo();
    print("로그아웃 : ${a}");
  }


    @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 20,
      margin: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
            },
            child: const Image(image: AssetImage('assets/images/deego_logo.png')),
          ),
          GestureDetector(
            onTap: signOut,
            child: Icon(Icons.logout_rounded, size: 40),
          ),
        ],
      ),
    );
  }
}
