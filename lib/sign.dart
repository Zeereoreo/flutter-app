import 'package:flutter/material.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  String idText = "";
  String nameText = "";
  String emailText = "";
  String passwordText = "";
  String passwordCheckText = "";
  bool _idError = false;
  bool _nameError = false;
  bool _emailError = false;
  bool _passwordError = false;
  bool _passwordCheckError = false;

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
                  maxLength: 16, // 최대 길이 제한
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      nameText = text;
                      _nameError = text.length < 2 || text.length >10;
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
                TextField(
                  onChanged: (text) {
                    setState(() {
                      passwordText = text;
                      _passwordError = text.length < 8 || text.length > 16;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    hintText: "8글자 이상 16글자 이하로 입력해주세요",
                    errorText: _passwordError ? '올바른 비밀번호를 입력하세요.' : null,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      passwordCheckText = text;
                      _passwordCheckError = text.length < 8 || text.length > 16;
                      _passwordCheckError = passwordText != passwordCheckText;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "비밀번호 확인",
                    hintText: "위의 비밀번호와 똑같이 입력해주세요",
                    errorText: _passwordCheckError ? '올바른 비밀번호를 입력하세요.' : null,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 가입하기 버튼 눌렀을 때의 동작
                    if (!_idError) {
                      // 모든 조건을 충족하면 여기에 로직 추가
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
}
