import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../main.dart';

class PhoneWidet extends StatefulWidget {


  const PhoneWidet({super.key});


  @override
  State<PhoneWidet> createState() => _PhoneWidetState();
}

class _PhoneWidetState extends State<PhoneWidet> {
  late String phone;


  String authNum = "";
  bool _phoneError = false;
  String userId = "";
  bool blueBtn = false;
  String phoneUUID = "";
  bool showAdditionalInput = false;
  bool showAuthBtn = false;
  bool completeAuth = false;
  bool authenticationCompleted = false;
  String newPassword = "";

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ]
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
          context.read<phoneUUIDStroe>().phoneUUID = responseData['id'];
        });
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


  void showPhoneAuth(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("인증번호"),
          content: TextField(
            decoration: InputDecoration(
              hintText: "받으신 인증번호를 입력해 주세요."
            ),
            keyboardType: TextInputType.number,
            maxLength: 4,
            textInputAction: TextInputAction.done,
          ),
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
}
