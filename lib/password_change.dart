import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'Wiget/phoneWidget.dart';
import 'Wiget/postBtn.dart';
import 'header.dart';
import 'main.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {

  late TextEditingController _idInfo;
  var _newPassword = TextEditingController();
  var _checkPassword = TextEditingController();

  @override
  void initState() {
    _idInfo = TextEditingController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          infoName("아이디"),
                          userInput("아이디를 입력해주세요.", _idInfo, TextInputType.text),
                          infoName("핸드폰번호"),
                          PhoneWidet(),
                          infoName("새로운 비밀번호"),
                          userInput("새로운 비밀번호를 입력해주세요.", _newPassword, TextInputType.text),
                          infoName("새로운 비밀번호 확인"),
                          userInput("새로운 비밀번호를 다시 입력해주세요.", _checkPassword, TextInputType.text),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PostBtn(btnName: "변경", btnFunction: postChange),
          ],
        ),
      ),
    );
  }

  Widget infoName(String name){
    return Text(
      name,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white
      ),
    );
  }

  Widget userInput(String hint, TextEditingController controller, keyboardType) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "$hint",
        filled: true,
        fillColor: const Color(0xFFF5F7FB),
        focusedBorder: const OutlineInputBorder(
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
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      obscureText: true,


    );
  }

  postChange()async{
    var res = await http.put(Uri.parse("https://test.deegolabs.kr/mobile/user/password"),
        headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
        body: {
          "password": "string"
        }
    );
    var result = jsonDecode(res.body);



    if(res.statusCode == 200){
      print("${result}");
      setState(() {

      });
    }else {
      print("${res.body}");
    }
  }
}
