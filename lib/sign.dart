import 'package:deego_client/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class Sign extends StatefulWidget {

  Sign({Key? key, required this.userId}) : super(key: key);
  final userId;


  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {


  String idText = "";
  String nameText = "";
  String emailText = "";
  String passwordText = "";
  String passwordCheckText = "";
  String birthText = "";
  bool _idError = false;
  bool _nameError = false;
  bool _emailError = false;
  bool _passwordError = false;
  bool _passwordCheckError = false;
  bool _birthError = false;




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 8,
                  margin: EdgeInsets.only(top: 100, right: 20, left: 20, bottom: 20),
                  child: const Image(image: AssetImage('assets/images/deego_logo.png')),
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      // 영어와 숫자만 사용 가능한 정규식
                      RegExp regex = RegExp(r'^[a-zA-Z0-9]*$');
                      bool isValid = regex.hasMatch(text);

                      // 길이가 16이상인 경우에는 추가로 입력을 막음
                      _idError = text.length < 2 || text.length > 16 || !isValid;

                      if (!_idError) {
                        // 글자 수가 16 미만이면 입력된 값 저장
                        idText = text;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "아이디",
                    hintText: "2글자 이상 16글자 이하로 입력해주세요",
                    errorText: _idError ? '영어와 숫자로만 입력해주세요.' : null,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLength: 16,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      nameText = text;
                      _nameError = text.length < 2 || text.length > 10;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "이름",
                    hintText: "2글자 이상 10글자 이하로 입력해주세요",
                    errorText: _nameError ? '올바른 이름을 입력하세요.' : null,
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLength: 10,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      emailText = text;
                      RegExp emailRegex = RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                      );
                      _emailError = !emailRegex.hasMatch(text);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "이메일",
                    hintText: "사용 가능한 이메일을 입력해주세요",
                    errorText: _emailError ? '올바른 이메일을 입력하세요.' : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      RegExp PasswordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$');
                      bool isValid = PasswordRegex.hasMatch(text);
                      passwordText = text;
                      _passwordError = text.length < 8 || text.length > 16 || !isValid;
                      //특수문자와 영어포함한 8글자자 이상 16글자 이하
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    hintText: "특수문자와 영어포함한 8글자 이상 16글자 이하로 입력해주세요",
                    errorText: _passwordError ? '올바른 비밀번호를 입력하세요.' : null,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      passwordCheckText = text;
                      _passwordCheckError = text.length < 8 || text.length > 16 || passwordText != passwordCheckText;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "비밀번호 확인",
                    hintText: "위의 비밀번호와 똑같이 입력해주세요",
                    errorText: _passwordCheckError ? '비밀번호가 일치하지 않습니다.' : null,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      // RegExp regex = RegExp(r'^[0-9]*$');
                      // bool isValid = regex.hasMatch(text);
                      //
                      // // 길이가 8이 아니거나 숫자가 아닌 경우 에러 표시
                      // _birthError = text.length != 8 || !isValid;

                      // if (!_birthError) {
                        // 숫자만 입력된 경우 값 저장
                        birthText = text;
                      // }
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "생년월일",
                    hintText: "예시) 19970920",
                    errorText: _birthError ? '숫자로 8자리를 입력하세요.' : null,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  maxLength: 10,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomRadioButton("남",1),
                      CustomRadioButton("여",2),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 가입하기 버튼 눌렀을 때의 동작
                    if (!_idError && !_passwordCheckError) {
                      // 서버로 데이터 전송
                      _sendDataToServer();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                  ),
                  child: Text("가입하기"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int value = 0;

  Widget CustomRadioButton(String text, int index) {
    return Container(
      width: MediaQuery.of(context).size.width/3,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (value == index) ? Color(0xFF00BEFF) : Colors.black,
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(color: (value == index) ? Color(0xFF00BEFF) : Colors.black),
        ),
      ),
    );
  }

  Future<void> _sendDataToServer() async {
    // 여기에 실제 서버로 데이터를 전송하는 로직을 작성합니다.
    final Uri uri = Uri.parse('https://backend.deegolabs.com/mobile/auth/user');
    DateTime birthDateTime = DateTime.parse(birthText);

    // 생년월일을 타임스탬프로 변환
    String birthDateFormat = birthDateTime.toIso8601String();


    final Map<String, dynamic> data = {
      'id': idText,
      'name': nameText,
      'email': emailText,
      'password': passwordText,
      'phoneId' : widget.userId,
      'gender': (value == 1) ? '남' : '여',
      "birthDateFormat" : birthDateFormat
    };

    final http.Response response = await http.post(uri, body: data);

    // 서버 응답에 대한 처리를 추가할 수 있습니다.
    if (response.statusCode == 201) {
      // 성공적으로 데이터를 전송한 경우
      // print('Data sent successfully');
      // print("${response.body}");
      // print(data);
      SignCompletedSnackBar.show(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Log()));

    } else {
      // print(data);

      // 데이터 전송 실패
      // print('Failed to send data. Status code: ${response.statusCode}');
      // print('Failed to send data. Status code: ${response.body}');

    }
  }
}
class SignCompletedSnackBar {
  static void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('회원가입이 완료되었습니다.'),
        duration: Duration(seconds: 2), // 스낵바 표시 시간 설정
      ),
    );
  }
}