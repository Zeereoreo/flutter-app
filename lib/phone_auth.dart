import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:deego_client/login.dart';
import 'package:deego_client/sign.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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
        body: SingleChildScrollView(
          child: Container(
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
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                num = text;
                                blueBtn = text.length == 11;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "핸드폰 번호",
                              hintText: "-를 제외한 핸드폰번호를 입력해주세요",
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            maxLength: 11,
                            enabled: !showAdditionalInput,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: blueBtn
                                ? () async {
                              sendPhoneNumberToServer(num);
                              setState(() {
                                showAdditionalInput = true;
                                blueBtn = false;
                              });
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              primary: blueBtn ? Colors.blue : Colors.grey,
                            ),
                            child: Text("인증하기"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (showAdditionalInput)
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  authNum = text;
                                  showAuthBtn = text.length == 4;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: "인증 번호",
                                hintText: "받으신 인증번호를 입력해 주세요",
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              maxLength: 4,
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
                                primary: showAuthBtn ? Colors.blue : Colors.grey,
                              ),
                              child: Text("인증완료"),
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
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Log()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF00BEFF),
                            minimumSize: Size(150, 50), // 크기 조절
                          ),
                          child: Text("뒤로가기")
                      ),
                      ElevatedButton(
                          onPressed: completeAuth ?
                              () async {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Sign(userId : userId),
                                ));
                          }
                          : null ,
                          style: ElevatedButton.styleFrom(
                            primary: completeAuth ? Color(0xFF00BEFF) : Colors.grey,
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
        ),
      ),
    );
  }

  Future<void> sendPhoneNumberToServer(String phoneNumber) async {
    final Uri url = Uri.parse('https://test.deegolabs.kr/common/phone');

    try {
      final response = await http.post(
        url,
        body: {'phone': phoneNumber},
      );

      if (response.statusCode == 201) {
        // 서버로의 요청이 성공한 경우
        print('핸드폰 번호 전송 성공');
        print("리스폰스 값 : ${response.body}");
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          userId = responseData['id']; // userId를 클래스 변수에 할당합니다.
        });
      } else {
        // 서버로의 요청이 실패한 경우
        print('핸드폰 번호 전송 실패');
        print('HTTP Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      // 오류 처리
      print('에러 발생: $error');
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
    Uri.parse('https://test.deegolabs.kr/common/phone/$userId');

    try {
      final authResponse = await http.put(
        authUrl,
        body: {'code': authCode},
      );

      if (authResponse.statusCode == 204) {
        // 서버로의 인증번호 전송이 성공한 경우
        print('인증번호 전송 성공');
        setState(() {
          completeAuth = true;
          authenticationCompleted = true;
          showAuthBtn = false;
        });
        showCompletionDialog(context);
        // 추가 작업 수행 가능
      } else {
        // 서버로의 인증번호 전송이 실패한 경우
        print('인증번호 전송 실패');
        print('HTTP Status Code: ${authResponse.statusCode}');
        print('Response Body: ${authResponse.body}');
      }
    } catch (error) {
      // 오류 처리
      print('에러 발생: $error');
    }
  }


}




