import 'dart:convert';

import 'package:deego_client/Wiget/phoneWidget.dart';
import 'package:deego_client/Wiget/postBtn.dart';
import 'package:deego_client/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  late TextEditingController _nameInfo;
  late TextEditingController _idInfo;
  late TextEditingController _emailInfo;
  late TextEditingController _phoneInfo;
 @override
  void initState() {
   _nameInfo = TextEditingController(text: context.read<userStore>().name);
   _idInfo = TextEditingController(text: context.read<userStore>().id);
   _emailInfo = TextEditingController(text: context.read<userStore>().email);
   _phoneInfo = TextEditingController(text: context.read<userStore>().phone);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Container(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            infoName("아이디"),
                            userInput("변경할 아이디를 입력하세요", _idInfo, TextInputType.text),
                            infoName("이름"),
                            userInput("변경할 이름을 입력하세요", _nameInfo, TextInputType.name),
                            infoName("이메일"),
                            userInput("변경할 이메일을 입력하세요", _emailInfo, TextInputType.emailAddress),
                            infoName("휴대전화 번호"),
                            PhoneWidet(),
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
      maxLines: null,
    );
  }

  postChange()async{
    var res = await http.put(Uri.parse("https://test.deegolabs.kr/mobile/user"),
        headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
        body: {
          "name" : _nameInfo.text,
          "email" : _emailInfo.text,
          "phoneId" : context.read<phoneUUIDStroe>().phoneUUID,
        }
    );
    var result = jsonDecode(res.body);
    print("${context
        .read<phoneUUIDStroe>()
        .phoneUUID}");
    print("${_nameInfo.text}");
    print("${_emailInfo.text}");

    if(res.statusCode == 200){
      print("${res.body}");
      setState(() {
        context.read<userStore>().id = result["id"];
        context.read<userStore>().email = result["email"];
        context.read<userStore>().phone = result["phone"];
      });
    }else {
      print("${res.body}");
    }
  }

}
