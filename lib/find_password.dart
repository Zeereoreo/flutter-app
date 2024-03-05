import 'dart:convert';

import 'package:deego_client/Wiget/phoneWidget.dart';
import 'package:deego_client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Wiget/pop_up.dart';
import 'login.dart';

class FindPassword extends StatefulWidget {
  const FindPassword({super.key});

  @override
  State<FindPassword> createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {
  String name = "";
  String phone = "";
  String authNum = "";
  bool _nameError = false;
  bool _phoneError = false;
  String id = "";
  bool blueBtn = false;
  String phoneUUID = "";
  bool showAdditionalInput = false;
  bool showAuthBtn = false;
  bool completeAuth = false;
  bool authenticationCompleted = false;
  String newPassword = "";
  bool _passwordError = false;
  bool _isPhoneVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/5,
              margin: EdgeInsets.only(top: 150,right: 20,left: 20,bottom: 20),
              // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
              child: const Image(image: AssetImage('assets/images/deego_logo.png')),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                children: [
                  TextField(
                    onChanged: (text){
                      setState(() {
                        _nameError = text.length < 2 || text.length > 10 ;
                        name = text;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: '아이디',
                      hintText: "아이디를 입력해 주세요.",
                      errorText: _nameError ? "2글자 이상 작성해 주세요." : null,
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
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (text){
                      setState(() {
                        RegExp PasswordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$');
                        bool isValid = PasswordRegex.hasMatch(text);
                        _passwordError = text.length < 8 || text.length > 16 || !isValid;
                        newPassword = text;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: '새로운 비밀번호',
                      hintText: "특수문자와 영어포함한 8글자 이상 16글자 이하로 입력해주세요",
                      errorText: _passwordError ? "올바른 비밀번호를 입력하세요." : null,
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
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  PhoneWidet(onPhoneVerified: (isVerified) {
                    setState(() {
                      _isPhoneVerified = isVerified; // 인증 여부 업데이트
                    });
                  },),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    changePassword();
                  }, child: Text("비밀번호 재설정"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: !_nameError && !_phoneError ?
                        Color(0xFF00BEFF) :
                        Color(0xFFB2EBFC)
                    ),
                  ),
                  Visibility(
                    visible: id.isNotEmpty,
                    child: Text(id,style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    ),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  changePassword()async{
    var res = await http.put(Uri.parse("https://backend.deegolabs.com/mobile/auth/password"),
        body: {
          "userId" : name,
          "phoneId" : context.read<phoneUUIDStroe>().phoneUUID,
          "password" : newPassword,
        }
    );

    if(res.statusCode == 200){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomPopup(
              content: "비밀번호가 변경 완료 되었습니다.",
              confirmText: "확인",
              onCancel: () => Navigator.pop(context),
              onConfirm: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Log()));
              },
            );
          });
    }else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomPopup(
              content: "정보를 다시한번 확인해 주시길 바랍니다.",
              confirmText: "확인",
              onCancel: () => Navigator.pop(context),
              onConfirm: () {
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FindPassword()));
              },
            );
          });
    }
  }





}
