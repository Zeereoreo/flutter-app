import 'dart:convert';

import 'package:deego_client/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Wiget/pop_up.dart';

class FindId extends StatefulWidget {
  const FindId({super.key});

  @override
  State<FindId> createState() => _FindIdState();
}

class _FindIdState extends State<FindId> {
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

  @override
  Widget build(BuildContext context) {
    print("$name");
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
                      labelText: '이름',
                      hintText: "이름을 입력해 주세요.",
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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (text){
                            setState(() {
                              _phoneError = text.length < 10 || text.length > 12 ;
                              phone = text;
                              blueBtn = text.length == 11;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: '핸드폰 번호',
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
                          maxLength: 11,
                        ),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(onPressed: blueBtn
                          ? () async {
                        sendPhoneNumberToServer(phone);
                        setState(() {
                          showAdditionalInput = true;
                          blueBtn = false;
                        });
                      }
                          : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueBtn ? Colors.blue : Colors.grey,
                          ),
                          child: Text("인증하기"))
                    ],
                  ),
                  SizedBox(height: 10,),
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
                                  await sendAuthCodeToServer(authNum, phoneUUID);
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
                    SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    findId();
                  }, child: Text("아이디 찾기"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_nameError && !_phoneError ?
                      Color(0xFF00BEFF) :
                      Color(0xFFB2EBFC)
                    ),
                  ),
                  // Visibility(
                  //   visible: id.isNotEmpty,
                  //   child: Text(id,style: TextStyle(
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 20,
                  //   ),),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  findId()async{
    var res = await http.post(Uri.parse("https://test.deegolabs.kr/mobile/auth/id"),
      body: {
        "name" : name,
        "phoneId" : phoneUUID,
      }
    );
    print("name : $name");
    var userId = jsonDecode(res.body);
    if(res.statusCode == 200) {
      print("$userId");
      setState(() {
        id = userId["userId"];
      });
      showDialog(context: context, builder: (BuildContext context){
        return CustomPopup(title: "찾으시는 아이디는", content: "${id}",
          onConfirm: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Log()));
          },
        );
      });
    }else{
      print(res.body);
    }
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
          phoneUUID = responseData['id'];
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
