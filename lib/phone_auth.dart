import 'dart:convert';
import 'package:deego_client/Wiget/phoneWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:deego_client/login.dart';
import 'package:deego_client/sign.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'Wiget/postBtn.dart';

class PhoneAuth extends StatefulWidget {

  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  String num = "";
  String authNum = "";
  String userId = "";
  bool showAdditionalInput = false;
  bool blueBtn = false;
  bool showAuthBtn = false;
  bool completeAuth = false;
  bool authenticationCompleted = false;
  bool isExist = false;
  bool _isPhoneVerified = false;
  late String phone;
  bool _phoneError = false;


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
        title: Text("회원가입",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 8,
                  margin: EdgeInsets.only(top: 100, right: 20, left: 20, bottom: 20),
                  child: const Image(image: AssetImage('assets/images/deego_logo.png')),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextField(
                        onChanged: (text){
                          setState(() {
                            _phoneError = text.length < 10 || text.length > 12 ;
                            phone = text;
                            blueBtn = text.length == 11;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "-를 제외한 핸드폰번호를 입력해주세요.",
                          errorText: _phoneError ? "제대로 된 핸드폰 번호를 입력해주세요." : null,
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
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        enabled: !showAdditionalInput,
                        // maxLength: 11,
                      ),
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                        onPressed: blueBtn
                            ? () async {
                          sendPhoneNumberToServer(phone);
                          setState(() {
                            showAdditionalInput = true;
                            blueBtn = false;
                          });
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blueBtn ? Colors.white : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: blueBtn? BorderSide(color: Colors.black) : BorderSide(color: Colors.grey),
                          ),

                        ),
                        child: Text("인증번호 전송", style: TextStyle(color: Colors.black),)),
                  ],
                ),
                if (showAdditionalInput)
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: TextField(
                                onChanged: (text) {
                                  setState(() {
                                    authNum = text;
                                    showAuthBtn = text.length == 4;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "받으신 인증번호를 입력해 주세요",
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
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                // maxLength: 4,
                                enabled: !authenticationCompleted
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: showAuthBtn
                                  ? () async {
                                await sendAuthCodeToServer(authNum, userId);
                                setState(() {

                                });
                              }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: showAuthBtn ? Colors.white : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: showAuthBtn? BorderSide(color: Colors.black) : BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: Text("인증번호 확인",style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ]
                    ),
                  ),
                Container(
                  margin: EdgeInsets.all(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Expanded(
                      //   child: ElevatedButton(
                      //       onPressed: () {
                      //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => Log()));
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         primary: Color(0xFF0089DD),
                      //         minimumSize: Size(150, 50), // 크기 조절
                      //       ),
                      //       child: Text("뒤로가기")
                      //   ),
                      // ),
                      // SizedBox(width: 20,),
                      ElevatedButton(
                          onPressed: completeAuth ?
                              () async {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Sign(userId : userId),
                                ));
                          }
                          : null ,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: completeAuth ? Color(0xFF0066FF) : Color(0xFFB6B6B6),
                            minimumSize: Size(150, 50), // 크기 조절
                          ),
                          child: Text("다음으로")
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendPhoneNumberToServer(String phoneNumber) async {
    final Uri url = Uri.parse('https://backend.deegolabs.com/common/phone');

    try {
      final response = await http.post(
        url,
        body: {'phone': phoneNumber},
      );

      if (response.statusCode == 201) {
        // 서버로의 요청이 성공한 경우
        // print('핸드폰 번호 전송 성공');
        // print("리스폰스 값 : ${response.body}");
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          userId = responseData['id'];
          isExist = responseData["isExistUser"];
        });
        if(responseData["isExistUser"] == true){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("존재하는 회원입니다."),
                content: Text("존재하는 회원이므로 다른 핸드폰 번호를 사용해주세요."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Log()));
                    },
                    child: Text("확인"),
                  ),
                ],
              );
            },
          );
        }else {
          setState(() {
            showAdditionalInput = true;
          });
        }
      } else {
        // 서버로의 요청이 실패한 경우
        // print('핸드폰 번호 전송 실패');
        // print('HTTP Status Code: ${response.statusCode}');
        // print('Response Body: ${response.body}');
      }
    } catch (error) {
      // 오류 처리
      // print('에러 발생: $error');
    }
  }

  void showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("인증 완료"),
          content: Text("인증이 완료되었습니다."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendAuthCodeToServer(String authCode, String userId) async {
    final Uri authUrl =
    Uri.parse('https://backend.deegolabs.com/common/phone/$userId');

    try {
      final authResponse = await http.put(
        authUrl,
        body: {'code': authCode},
      );

      if (authResponse.statusCode == 204) {
        // 서버로의 인증번호 전송이 성공한 경우
        // print('인증번호 전송 성공');
        setState(() {
          completeAuth = true;
          authenticationCompleted = true;
          showAuthBtn = false;
        });
        showCompletionDialog(context);
        // 추가 작업 수행 가능
      } else {
        // 서버로의 인증번호 전송이 실패한 경우
        // print('인증번호 전송 실패');
        // print('HTTP Status Code: ${authResponse.statusCode}');
        // print('Response Body: ${authResponse.body}');
      }
    } catch (error) {
      // 오류 처리
      // print('에러 발생: $error');
    }
  }


}




