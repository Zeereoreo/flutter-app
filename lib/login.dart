import 'dart:convert';
import 'dart:io';
import 'package:deego_client/find_password.dart';
import 'package:deego_client/phone_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:deego_client/home.dart';
import 'package:deego_client/sns_api_sevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:provider/provider.dart';
import 'find_id.dart';
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
  // final storage = FlutterSecureStorage();
  // dynamic userInfoAccessToken = '';
  // dynamic userInfoRefreshToken = '';

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }
  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    // userInfoAccessToken = await storage.read(key:'accessToken');
    // userInfoRefreshToken = await storage.read(key:'refreshToken');
    //
    // // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    // if (userInfoRefreshToken != null) {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => Home(accessToken: userInfoAccessToken),
    //     ),
    //   );
    // } else {
    //   print('로그인이 필요합니다');
    // }
  }

  @override
  Widget build(BuildContext context) {
  // print("${context.read<AuthStore>().accessToken}");
  // print("${context.read<AuthStore>().refreshToken}");

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
                height: MediaQuery.of(context).size.height*0.15,
                margin: EdgeInsets.only(top: 100,right: 20,left: 20,bottom: 10),
                // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                child: const Image(image: AssetImage('assets/images/deego_logo.png')),
              ),
              Container(
                margin: EdgeInsets.all(10),
                // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "아이디",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                     TextField(
                      onChanged: (text){
                        setState(() {
                          _idError = text.length < 2 || text.length > 16 ;

                          id = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '아이디를 입력해 주세요.',
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
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "비밀번호",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextField(
                       onChanged: (text){
                         setState(() {
                           _passwordError = text.length < 8 || text.length > 16;
                           password = text;
                         });
                       },
                      decoration: InputDecoration(
                        hintText: '비밀번호를 입력해 주세요.',
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: (){
                            _loginToServer();
                          },
                          child: Text('로그인',),
                          style:
                          ElevatedButton.styleFrom(

                            backgroundColor: !_idError && !_passwordError ?
                                Color(0xFF0099FF)
                                :
                                Color(0xFFB2EBFC),

                          ),
                      ),
                    ),
                    TextBtn(),
                    SizedBox(height: 100,),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              height: 20,
                              thickness: 2,
                              color: Color(0xFFA3A3A3),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "SNS 계정으로 로그인",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xFFA3A3A3)),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              height: 20,
                              thickness: 2,
                              color: Color(0xFFA3A3A3),
                            ),
                          ),
                        ],
                      ),
                    ),
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
    final Uri uri = Uri.parse("https://backend.deegolabs.com/mobile/auth");

    final Map<String, dynamic> data = {
      'id': id,
      'password': password,
    };

    final http.Response response = await http.post(uri,
        body: data
    );

    if(response.statusCode == 200){
      // print("${response.body}");
      final Map<String, dynamic> responseData = json.decode(response.body);


      context.read<userStore>().name = responseData['user']["name"];
      context.read<userStore>().id = responseData['user']["id"];
      context.read<userStore>().email = responseData['user']["email"];
      context.read<userStore>().phone = responseData['user']["phone"];

      context.read<AuthStore>().accessToken = responseData['accessToken'];


      await getUserPoint(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Home(accessToken: responseData['accessToken']),
        ),
      );
      // await storage.write(
      //   key: 'login',
      //   value: responseData['accessToken'],
      // );
    }
    else{
      print("${response.statusCode}");

    }

  }

// getAutoToken()async{
//   try{
//     var res = await http.get(Uri.parse("https://test.deegolabs.kr/mobile/auth/auto"),
//         headers: {
//           "X-ACCESS-TOKEN" : userInfoAccessToken
//         }
//     );
//     var result = json.decode(res.body);
//     print("refreshToken  =  ${result}");
//     setState(() {
//       userInfoAccessToken = result["accessToken"];
//       context.read<AuthStore>().refreshToken = result["accessToken"];
//     });
//     await storage.write(
//       key: 'refreshToken',
//       value: result['accessToken'],
//     );
//   }catch(e){
//     print(e);
//   }
// }
}
Future<void> getUserPoint(BuildContext context) async {
  // print("context : ${context}");
  final url = Uri.https("backend.deegolabs.com", "/mobile/point");
  // print("header : ${context.read<AuthStore>().accessToken}");
  final response = await http.get(
      url,
      headers : {
        "Authorization" : "Bearer ${context.read<AuthStore>().accessToken}"
      }
  );

  // print("body :${response.body}");

  if(response.statusCode == 200){
    // print("포인트불러오기성공");
    final Map<String, dynamic> responseData = json.decode(response.body);
    context.read<pointStore>().current = responseData["current"];
    context.read<pointStore>().spents = responseData["spents"];

    // print("point :${context.read<pointStore>().current}");

  } else{

    // print("실패 :${response.body}");
  }
}

class TextBtn extends StatelessWidget {
  const TextBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FindId()));
              },
              child: Text('아이디 찾기',
                style: TextStyle(color: Colors.black),
              ),

          ),
          Text(
            '|',
            style: TextStyle(fontSize: 16),
          ),
          TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FindPassword()));
              },
              child: Text('비밀번호 찾기',
                style: TextStyle(color: Colors.black),),

          ),
          Text(
            '|',
            style: TextStyle(fontSize: 16),
          ),
           TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhoneAuth()));
              },
              child: Text('회원가입',
                style: TextStyle(color: Colors.black),),
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
  final storage = FlutterSecureStorage();

  getNaver()async{

    // final NaverLoginResult result = await FlutterNaverLogin.logIn();
    // NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
    // NaverLoginResult loginResult = await FlutterNaverLogin.logIn();
    final NaverLoginResult result = await FlutterNaverLogin.logIn();
    NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
    // print("토큰:${res.accessToken}");
    if (result.status == NaverLoginStatus.loggedIn) {
      // print("리스폰스 = ${result}");
      // print('액세스토큰 = ${result.accessToken.accessToken}');
      // print('id = ${result.account.id}');
      // print('email = ${result.account.email}');
      // print('name = ${result.account.name}');
      // print(res);
      await SnsApiService().sendTokenToServer(context, 'Naver', res.accessToken, res.refreshToken);
      await getUserPoint(context);

      setState(() {
        _loginPlatform = LoginPlatform.naver;
        // context.read<AuthStore>().accessToken = result.accessToken.accessToken;

      });

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(accessToken : res.accessToken)));

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
      // print("토큰:$token");
      // print("토큰:${token.accessToken}");
      context.read<AuthStore>().accessToken = token.accessToken;
      // await SnsApiService().sendTokenToServer(context, 'Kakao', token.accessToken, token.refreshToken);
      await getUserPoint(context);
      // final profileInfo = json.decode(response.body);
      // print(profileInfo.toString());
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(accessToken: token.accessToken)));

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });

    } catch (error) {
      // print('카카오톡으로 로그인 실패 $error');
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
                child: const Image(
                  image: AssetImage('assets/images/naverlogo.png'),
                  width: 100,
                  height: 50,
                ),),
          ),
          Container(
            child: TextButton(onPressed: (){
              setState(() {
                getData();
              });
            }, child: const Image(
              image: AssetImage('assets/images/kakaologo.png'),
              width: 100,
              height: 50,
            ),),
          )
        ],
      ),
    );
  }

}
