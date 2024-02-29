import 'package:deego_client/header.dart';
import 'package:deego_client/login.dart';
import 'package:deego_client/password_change.dart';
import 'package:deego_client/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'horizontaldasheddivider.dart';
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
      appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true, // 제목 가운데 정렬
          title: Text("정보 변경",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            // const Header(),
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
                  HorizontalDashedDivider(thickness: 1,length: 5,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),
                  MyPageBtn("비밀번호 재설정", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordChange()),
                    );
                  }),
                  HorizontalDashedDivider(thickness: 1,length: 5,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),
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
