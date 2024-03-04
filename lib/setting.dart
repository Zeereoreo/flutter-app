import 'package:deego_client/announcements.dart';
import 'package:deego_client/my_page.dart';
import 'package:deego_client/privacy_policy.dart';
import 'package:deego_client/question_list.dart';
import 'package:deego_client/service_faq.dart';
import 'package:deego_client/terms_of_use.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

import 'bottom_menu.dart';
import 'header.dart';
import 'horizontaldasheddivider.dart';
import 'login.dart';
import 'login_platform.dart';
import 'main.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserState();
    });
  }

  checkUserState() async {
    userInfo = await storage.read(key: 'login');
    if (userInfo == null) {
      // print('로그인 페이지로 이동');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Log()));
    } else {
      // print('로그인 중');
    }
  }

  @override
  Widget build(BuildContext context) {

    var name = '${context.read<userStore>().name}';
    var tab = context.read<footerStore>().tab;

    String accessToken = Provider.of<AuthStore>(context).accessToken;

    void signOut() async {
      switch (_loginPlatform) {
        case LoginPlatform.kakao:
          await UserApi.instance.logout();
          tab == 0;
          logout();
          break;
        case LoginPlatform.naver:
          await FlutterNaverLogin.logOut();
          tab == 0;
          logout();
          break;
        case LoginPlatform.none:
          tab == 0;
          logout();
          break;
        case LoginPlatform.logout:
          tab == 0;
          break;
      }
      setState(() {
        _loginPlatform = LoginPlatform.logout;
      });

    }

    return WillPopScope(
      onWillPop: (){
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            leading: SizedBox(), // 뒤로가기 버튼 제거
            centerTitle: true, // 제목 가운데 정렬
            title: Text("마이 메뉴",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)
        ),
        body: Container(
          // margin: EdgeInsets.all(10),
          color: Color(0xFFF8F8F8),

          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height/6,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21,color: Color(0xFF0066FF)),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '님',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("디고와 함께 지구의 온도를 낮춰보세요!",
                        style: TextStyle( fontSize: 19, color: Colors.black),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 10,
                  color: Color(0xFFECECEC),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      TextButton(
                      onPressed: () {
                          signOut();
                              },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "로그아웃",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,),
                              ],
                            ),
                          ),
                        ),
                      HorizontalDashedDivider(thickness: 1,length: 5,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),
                      SetBtn(buttonText: '정보 관리',onPressed: (c) => MyPage()),
                      // HorizontalDashedDivider(thickness: 1,length: 5,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),
                      // SetBtn(buttonText: '핸드폰 번호 변경',onPressed: (c) => MyPage()),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 10,
                  color: Color(0xFFECECEC),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Image.asset("assets/images/help_center_icon.png",
                              width: MediaQuery.of(context).size.width*0.07,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 10,),
                            Text("디고 고객센터",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      SetBtn(buttonText: '디고 가이드',onPressed: (c) => ServiceFAQ(),),
                      HorizontalDashedDivider(thickness: 1,length: 5,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),
                      SetBtn(buttonText: 'FAQ',onPressed: (c) => ServiceFAQ(),),
                      HorizontalDashedDivider(thickness: 1,length: 5,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),
                      SetBtn(buttonText: '문의하기',onPressed: (c) => QuestionList(),),
                      HorizontalDashedDivider(thickness: 1,length: 5,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),
                      // SetBtn(buttonText: '정보 관리',onPressed: (c) => MyPage()),
                      SetBtn(buttonText: "공지사항",onPressed: (c) => Announcements()),
                      HorizontalDashedDivider(thickness: 1,length: 5,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),
                      SetBtn(buttonText: '서비스 이용 약관', onPressed: (c) => TermsOfUse() , ),
                      HorizontalDashedDivider(thickness: 1,length: 5,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),
                      SetBtn(buttonText: '개인정보 처리 방침', onPressed: (c) => PrivacyPolicy() , ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomMenu(),
      ),
    );
  }
}

class SetBtn extends StatelessWidget {
  final String buttonText;
  final Widget Function(BuildContext) onPressed;

  SetBtn({Key? key, required this.buttonText, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => onPressed(context)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
              ),
            ),
            Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,),
          ],
        ),
      ),
    );
  }
}


class Set extends StatefulWidget {
  final String btnText;

  Set({super.key, required this.btnText});

  @override
  State<Set> createState() => _SetState();
}

class _SetState extends State<Set> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white38,
      child: ExpansionTile(
        // backgroundColor: Colors.white38,
        // collapsedBackgroundColor: Colors.white38,
        title: Text("${widget.btnText}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white
          ),
        ),
        children: [
          // ServiceFAQ()
        ],
      ),
    );
  }
}

