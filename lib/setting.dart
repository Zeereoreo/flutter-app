import 'package:deego_client/announcements.dart';
import 'package:deego_client/my_page.dart';
import 'package:deego_client/privacy_policy.dart';
import 'package:deego_client/question_list.dart';
import 'package:deego_client/service_faq.dart';
import 'package:deego_client/terms_of_use.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_menu.dart';
import 'header.dart';
import 'main.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = '${context.read<userStore>().name}';

    return WillPopScope(
      onWillPop: (){
        return Future(() => false);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bgimage.png'),
          ),
        ),
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                const Header(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height/6,
                            padding: EdgeInsets.all(20),
                            child: Text.rich(
                              TextSpan(
                                text: name,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: '님, 디고와 함께 \n 지구의 온도를 낮춰보세요!',
                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Set(btnText: '디고 가이드',),
                              SetBtn(buttonText: 'FAQ',onPressed: (c) => ServiceFAQ(),),
                              SetBtn(buttonText: '문의하기',onPressed: (c) => QuestionList(),),
                              SetBtn(buttonText: '정보 관리',onPressed: (c) => MyPage()),
                              SetBtn(buttonText: "공지사항",onPressed: (c) => Announcements()),
                              // setBtn(buttonText: '고객 센터',),
                              // setBtn(buttonText: '공지 사항',),
                              SetBtn(buttonText: '서비스 이용 약관', onPressed: (c) => TermsOfUse() , ),
                              SetBtn(buttonText: '개인정보 처리 방침', onPressed: (c) => PrivacyPolicy() , ),
                              // setBtn(buttonText: '버전 정보',),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomMenu(),
        ),
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
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white38
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            Icon(Icons.arrow_right_outlined),
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
        borderRadius: BorderRadius.circular(10)
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

