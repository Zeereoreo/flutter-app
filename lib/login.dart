import 'package:deego_client/header.dart';
import 'package:deego_client/home.dart';
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
              margin: EdgeInsets.only(top: 200,right: 20,left: 20,bottom: 20),
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
              onPressed: (){},
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


class _OuthBtnState extends State<OuthBtn> {

  getNaver()async{
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.loggedIn) {
      print('accessToken = ${result.accessToken}');
      print('id = ${result.account.id}');
      print('email = ${result.account.email}');
      print('name = ${result.account.name}');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));

    }


  }

  getData() async {
    // 카카오 로그인 구현 예제

// 카카오톡 설치 여부 확인
// 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }

    User user;

    try {
      user = await UserApi.instance.me();
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
      return;
    }

    List<String> scopes = [];

    if (user.kakaoAccount?.emailNeedsAgreement == true) {
      scopes.add('account_email');
    }
    if (user.kakaoAccount?.birthdayNeedsAgreement == true) {
      scopes.add("birthday");
    }
    if (user.kakaoAccount?.birthyearNeedsAgreement == true) {
      scopes.add("birthyear");
    }
    if (user.kakaoAccount?.ciNeedsAgreement == true) {
      scopes.add("account_ci");
    }
    if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) {
      scopes.add("phone_number");
    }
    if (user.kakaoAccount?.profileNeedsAgreement == true) {
      scopes.add("profile");
    }
    if (user.kakaoAccount?.ageRangeNeedsAgreement == true) {
      scopes.add("age_range");
    }

    if (scopes.length > 0) {
      print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');

      // OpenID Connect 사용 시
      // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
      // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
      // scopes.add("openid")

      //scope 목록을 전달하여 카카오 로그인 요청
      OAuthToken token;
      try {
        token = await UserApi.instance.loginWithNewScopes(scopes);
        print('현재 사용자가 동의한 동의 항목: ${token.scopes}');
      } catch (error) {
        print('추가 동의 요청 실패 $error');
        return;
      }

      // 사용자 정보 재요청
      try {
        User user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
            '\n회원번호: ${user.id}'
            '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
            '\n이메일: ${user.kakaoAccount?.email}');
      } catch (error) {
        print('사용자 정보 요청 실패 $error');
      }
    }


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
