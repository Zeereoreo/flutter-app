import 'package:deego_client/header.dart';
import 'package:flutter/material.dart';

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
                  MyPageBtn("사용자 정보 수정"),
                  MyPageBtn("비밀번호 재설정"),
                  MyPageBtn("SNS 연동하기"),
                  MyPageBtn("로그 아웃"),
                  MyPageBtn("회원 탈퇴"),
                  ],
              ),
            )
          ],
        ),
      ),
    )
    );
  }

  Widget MyPageBtn (String buttonText){
    return TextButton(onPressed: (){

    }, child: Container(
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
}
