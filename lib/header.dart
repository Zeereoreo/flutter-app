import 'package:deego_client/home.dart';
import 'package:deego_client/login.dart';
import 'package:deego_client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

import 'login_platform.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}


class _HeaderState extends State<Header> {

  LoginPlatform _loginPlatform = LoginPlatform.none;

  static final storage = FlutterSecureStorage();
  dynamic userInfo = '';

  logout() async {
    await storage.delete(key: 'login');
    context.read<AuthStore>().accessToken = "";
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Log()));
  }
  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserState();
    });
  }
    checkUserState() async {
      userInfo = await storage.read(key: 'login');
      if (userInfo == null) {
        print('로그인 페이지로 이동');
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Log()));
      } else {
        print('로그인 중');
      }
    }
    @override
  Widget build(BuildContext context) {
      var tab = context.read<footerStore>().tab;

      String accessToken = Provider.of<AuthStore>(context).accessToken;

      void signOut() async {
        switch (_loginPlatform) {
          case LoginPlatform.kakao:
            await UserApi.instance.logout();
            logout();
            break;
          case LoginPlatform.naver:
            await FlutterNaverLogin.logOut();
            logout();
            break;
          case LoginPlatform.none:
            logout();
            break;
          case LoginPlatform.logout:
            break;
        }
        setState(() {
          _loginPlatform = LoginPlatform.logout;
        });

      }
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 20,
      margin: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
                context.read<footerStore>().tab == 0;
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(accessToken:accessToken)));
            },
            child: const Image(image: AssetImage('assets/images/deego_logo.png')),
          ),
          GestureDetector(
            onTap: signOut,
            child: const Icon(Icons.logout_rounded, size: 40),
          ),
        ],
      ),
    );
  }
}
