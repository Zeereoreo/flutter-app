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
  bool _isPhoneVerified = false;

  @override
  void initState() {
    _idInfo = TextEditingController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
        title: Text("비밀번호 재설정",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            // const Header(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoName("아이디"),
                          SizedBox(height: 10,),
                          userInput("아이디를 입력해주세요.", _idInfo, TextInputType.text),
                          SizedBox(height: 10,),
                          infoName("핸드폰번호"),
                          SizedBox(height: 10,),
                          PhoneWidet(onPhoneVerified: (isVerified) {
                            setState(() {
                              _isPhoneVerified = isVerified; // 인증 여부 업데이트
                            });
                          },),
                          SizedBox(height: 10,),
                          infoName("새로운 비밀번호"),
                          SizedBox(height: 10,),
                          userInput("새로운 비밀번호를 입력해주세요.", _newPassword, TextInputType.text),
                          SizedBox(height: 10,),
                          infoName("새로운 비밀번호 확인"),
                          SizedBox(height: 10,),
                          userInput("새로운 비밀번호를 다시 입력해주세요.", _checkPassword, TextInputType.text),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PostBtn(btnName: "변경", btnFunction: postChange, isPhoneVerified: _isPhoneVerified,),
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
          fontSize: 16,
          color: Colors.black
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
    var res = await http.put(Uri.parse("https://backend.deegolabs.com/mobile/user/password"),
        headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
        body: {
          "password": "string"
        }
    );
    var result = jsonDecode(res.body);



    if(res.statusCode == 200){
      // print("${result}");
      setState(() {

      });
    }else {
      // print("${res.body}");
    }
  }
}
