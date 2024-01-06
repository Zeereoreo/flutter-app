import 'dart:convert';
import 'dart:io';
import 'package:deego_client/phone_auth.dart';
import 'package:http/http.dart' as http;
import 'package:deego_client/home.dart';
import 'package:deego_client/sns_api_sevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:provider/provider.dart';
import 'login_platform.dart';
import 'main.dart';




class Log extends StatefulWidget {
  const Log({super.key});


  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  String id = "";
  String password = "";
  bool _idError = false;
  bool _passwordError = false;



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
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
                width: double.infinity,
                child: Column(
                  children: [
                     TextField(
                      onChanged: (text){
                        setState(() {
                          _idError = text.length < 2 || text.length > 16 ;

                          id = text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: '아이디',
                        hintText: 'Enter your id',
                        errorText: _idError ? '영어와 숫자로만 입력해주세요.' : null,
                        filled: true,
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
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                     ),
                    SizedBox(height: 10),
                    TextField(
                       onChanged: (text){
                         setState(() {
                           _passwordError = text.length < 8 || text.length > 16;
                           password = text;
                         });
                       },
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        hintText: 'Enter your password',
                        errorText: _passwordError ? '올바른 비밀번호를 입력하세요.' : null,
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
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
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: (){
                            _loginToServer();
                          },
                          child: Text('로그인'),
                          style:
                          ElevatedButton.styleFrom(
                            primary:
                                !_idError && !_passwordError ?
                                Color(0xFF00BEFF)
                                :
                                Color(0xFFB2EBFC)
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
      ),
    );
  }
  Future<void> _loginToServer() async {
    final Uri uri = Uri.parse("https://test.deegolabs.com:3000/mobile/auth");

    final Map<String, dynamic> data = {
      'id': id,
      'password': password,
    };

    final http.Response response = await http.post(uri,
        body: data
    );

    if(response.statusCode == 200){
      print("${response.body}");
      final Map<String, dynamic> responseData = json.decode(response.body);


      context.read<userStore>().name = responseData['user']["name"];

      context.read<AuthStore>().accessToken = responseData['accessToken'];


      await getUserPoint(context);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Home(accessToken: responseData['accessToken']),
        ),
      );

    }
    else{
      // print("${response.statusCode}");
      // print("${response.statusCode}");

    }

  }
}
Future<void> getUserPoint(BuildContext context) async {
  print("context : ${context}");
  final url = Uri.https("test.deegolabs.com:3000", "/mobile/point");
  print("header : ${context.read<AuthStore>().accessToken}");
  final response = await http.get(
      url,
      headers : {
        "Authorization" : "Bearer ${context.read<AuthStore>().accessToken}"
      }
  );

  print("body :${response.body}");

  if(response.statusCode == 200){
    print("포인트불러오기성공");
    final Map<String, dynamic> responseData = json.decode(response.body);
    context.read<pointStore>().current = responseData["current"];
    print("point :${context.read<pointStore>().current}");

  } else{

    print("실패 :${response.body}");
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhoneAuth()));
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
    NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
    print("토큰:${res.accessToken}");
    if (result.status == NaverLoginStatus.loggedIn) {
      print("리스폰스 = ${result}");
      print('액세스토큰 = ${result.accessToken.accessToken}');
      print('id = ${result.account.id}');
      print('email = ${result.account.email}');
      print('name = ${result.account.name}');
      await SnsApiService().sendTokenToServer(context, 'Naver', res.accessToken);
      // await getUserPoint(context);
      setState(() {
        _loginPlatform = LoginPlatform.naver;
        // context.read<AuthStore>().accessToken = result.accessToken as String;

      });

      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(accessToken : res.accessToken)));

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
      context.read<AuthStore>().accessToken = token.accessToken;
      await SnsApiService().sendTokenToServer(context, 'Kakao', token.accessToken);
      await getUserPoint(context);
      // final profileInfo = json.decode(response.body);
      // print(profileInfo.toString());
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(accessToken: token.accessToken)));

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });

    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
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
