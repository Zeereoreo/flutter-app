import 'package:deego_client/header.dart';
import 'package:deego_client/login.dart';
import 'package:deego_client/password_change.dart';
import 'package:deego_client/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'main.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/bgimage.png'), // 배경 이미지
    ),
    ),
    child: Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            const Header(),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  MyPageBtn("사용자 정보 수정", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserInfo()),
                    );
                  }),
                  MyPageBtn("비밀번호 재설정", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordChange()),
                    );
                  }),
                  MyPageBtn("로그 아웃", null),
                  MyPageBtn("회원 탈퇴", deleteUser),
                  ],
              ),
            )
          ],
        ),
      ),
    )
    );
  }

  Widget MyPageBtn (String buttonText,VoidCallback? onfunction){
    return TextButton(onPressed: onfunction,
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
    ),);
  }

  deleteUser()async{
    var res = await http.delete(Uri.parse("https://test.deegolabs.kr/mobile/user/resign"),
      headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
    );
    if(res.statusCode == 200){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Log()));
    } else{
      print("${res.body}");
    }
  }
}
