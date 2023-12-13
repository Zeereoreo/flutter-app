import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:deego_client/header.dart';
import 'package:deego_client/home.dart';
import 'package:deego_client/sign.dart';
import 'package:deego_client/sns_api_sevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

import 'login_platform.dart';




class Log extends StatefulWidget {
  const Log({super.key});


  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/5,
              margin: EdgeInsets.only(top: 150,right: 20,left: 20,bottom: 20),
              // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
              child: const Image(image: AssetImage('assets/images/deego_logo.png')),
            ),
            Container(
              margin: EdgeInsets.all(10),
              // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              width: 400,
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: '아이디',
                      hintText: 'Enter your id',
                      filled: true, // 배경색을 적용하기 위해 filled 속성을 true로 설정
                      fillColor: Color(0xFFF5F7FB),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xFFF5F7FB)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      hintText: 'Enter your password',
                      labelStyle: TextStyle(color: Colors.grey),
                      filled: true, // 배경색을 적용하기 위해 filled 속성을 true로 설정
                      fillColor: Color(0xFFF5F7FB), // 배경색을 #F5F7FB로 지정
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xFFF5F7FB)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 400,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Text('로그인'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFB2EBFC)
                        ),
                    ),
                  ),
                  TextBtn(),
                  OuthBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextBtn extends StatelessWidget {
  const TextBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: (){},
              child: Text('아이디 찾기', style: TextStyle(color: Colors.black),),
          ),
          Text(' | '),
          TextButton(
              onPressed: (){},
              child: Text('비밀번호 찾기', style: TextStyle(color: Colors.black),),

          ),
          Text(' | '), TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Sign()));
              },
              child: Text('회원가입', style: TextStyle(color: Colors.black),),
          )
        ],
      ),
    );
  }
}

class OuthBtn extends StatefulWidget {
  const OuthBtn({super.key});


  @override
  State<OuthBtn> createState() => _OuthBtnState();
}

LoginPlatform _loginPlatform = LoginPlatform.none;


class _OuthBtnState extends State<OuthBtn> {

  getNaver()async{
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.loggedIn) {
      print('accessToken = ${result.accessToken}');
      print('id = ${result.account.id}');
      print('email = ${result.account.email}');
      print('name = ${result.account.name}');

      setState(() {
        _loginPlatform = LoginPlatform.naver;
      });

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));

    }


  }

  getData() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );
      print("토큰:$token");
      print("토큰:${token.accessToken}");
      await SnsApiService().sendTokenToServer('Kakao', token.accessToken);
      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });

    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));

    }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: TextButton(onPressed: (){
              setState(() {
                getNaver();
              });
            },
                child: const Text('네이버로고')),
          ),
          Container(
            child: TextButton(onPressed: (){
              setState(() {
                getData();
              });
            }, child: Text('카카오로그인')),

          )
        ],
      ),
    );
  }
}
