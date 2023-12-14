import 'package:flutter/material.dart';

class Sign extends StatelessWidget {
  const Sign({super.key});

  @override
  Widget build(BuildContext context) {
    // 상태 변수 정의
    TextEditingController idController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();

    void _sendUserDataToServer() {
      // 사용자가 입력한 정보 가져오기
      final String id = idController.text;
      final String name = nameController.text;
      final String password = passwordController.text;
      final String confirmPassword = confirmPasswordController.text;
      final String email = emailController.text;
      final String phoneNumber = phoneNumberController.text;

      // TODO: 서버로 데이터 전송 (SnsApiService().sendUserDataToServer 메서드 호출 등)

      // 예제로 콘솔에 출력
      print('ID: $id');
      print('Name: $name');
      print('Password: $password');
      print('Confirm Password: $confirmPassword');
      print('Email: $email');
      print('Phone Number: $phoneNumber');
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 7,
              margin: EdgeInsets.only(top: 100, right: 20, left: 20, bottom: 20),
              child: const Image(image: AssetImage('assets/images/deego_logo.png')),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              width: double.infinity,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: '아이디',
                    hintText: 'Enter your id',
                    keyboardType: TextInputType.text,
                    controller: idController,
                  ),
                  CustomTextField(
                    labelText: '이름',
                    hintText: 'Enter your name',
                    keyboardType: TextInputType.text,
                    controller: nameController,
                  ),
                  CustomTextField(
                    labelText: '비밀번호',
                    hintText: 'Enter your password',
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                  ),
                  CustomTextField(
                    labelText: '비밀번호 확인',
                    hintText: 'Enter your password',
                    keyboardType: TextInputType.text,
                    controller: confirmPasswordController,
                  ),
                  CustomTextField(
                    labelText: '이메일',
                    hintText: 'Enter your e-mail',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  CustomTextField(
                    labelText: '핸드폰 번호',
                    hintText: 'Enter your phone number',
                    keyboardType: TextInputType.number,
                    controller: phoneNumberController,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _sendUserDataToServer,
                      child: Text('회원가입'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFB2EBFC),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          filled: true,
          fillColor: Color(0xFFF5F7FB),
          focusedBorder: OutlineInputBorder(
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
      ),
    );
  }
}
