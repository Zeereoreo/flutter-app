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
    return  Scaffold(
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
    bool? confirm = await _showConfirmationDialog();
    if (confirm != null && confirm){
      var res = await http.delete(Uri.parse("https://test.deegolabs.kr/mobile/user/resign"),
      headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},);
    if(res.statusCode == 204){
      print("${res.body}");
      SignCompletedSnackBar.show(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Log()));
    } else{
      print("${res.statusCode}");
      print("${res.body}");
    }
  }

  }
  Future<bool?> _showConfirmationDialog() async {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('회원 탈퇴'),
          content: Text('정말로 회원 탈퇴하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('아니오'),
              onPressed: () {
                Navigator.of(context).pop(false); // 취소
              },
            ),
            TextButton(
              child: Text('예'),
              onPressed: () {
                Navigator.of(context).pop(true); // 확인
              },
            ),
          ],
        );
      },
    );
  }

}
class SignCompletedSnackBar {
  static void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('회원탈퇴가 완료되었습니다.'),
        duration: Duration(seconds: 2), // 스낵바 표시 시간 설정
      ),
    );
  }
}
