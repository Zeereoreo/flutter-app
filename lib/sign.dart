import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Sign extends StatefulWidget {
  Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final formKey = GlobalKey<FormState>();
  String id = '';
  String email = '';
  String password = '';
  String checkpassword = '';
  String name = '';
  String phoneId = '';
  bool isVerificationInProgress = false;
  bool isVerificationCompleted = false;
  bool showAdditionalInput = false;
  bool blueBtn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        // height: MediaQuery.of(context).size.height/3,
        // decoration: BoxDecoration(
        //     border: Border.all(color: Colors.black)
        // ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.black)
              // ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  renderTextFormField(
                      label: '아이디',
                      onSaved: (val) {
                        setState(() {
                          id = val!;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return '아이디는 필수사항입니다.';
                        }

                        if (val.length < 2) {
                          return '아이디는 두 글자 이상 입력 해주셔야합니다.';
                        }
                        if (val.length > 16) {
                          return '아이디는 열 여섯자 이하로 입력 해주셔야합니다.';
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.next

                  ),
                  renderTextFormField(
                      label: '이메일',
                      onSaved: (val) {
                        setState(() {
                          email = val!;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return '이메일은 필수사항입니다.';
                        }

                        if (!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(val)) {
                          return '잘못된 이메일 형식입니다.';
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.next

                  ),
                  renderTextFormField(
                      label: '비밀번호',
                      onSaved: (val) {
                        setState(() {
                          password = val!;
                        });
                      },
                      validator: (val) {
                        print(val);
                        if (val!.isEmpty) {
                          return '비밀번호는 필수사항입니다.';
                        }

                        if (val.length < 8) {
                          return '8자 이상 입력해주세요!';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next

                    // obscureText: true,
                  ),
                  renderTextFormField(
                      label: '비밀번호 확인',
                      onSaved: (val) {
                        setState(() {
                          checkpassword = val!;
                        });
                      },
                      validator: (val) {
                        print(val);
                        if (val!.isEmpty) {
                          return '비밀번호 확인은 필수사항입니다.';
                        }
                        // if (val != password) {
                        //   print("어디지");
                        //   return '비밀번호가 일치하지 않습니다.';
                        // } else {
                        //   print("어디야");
                        //   return null;
                        // }
                        print("어디서");
                        return null; // 일치할 때는 null을 반환하여 에러 메시지가 표시되지 않도록 함
                      },
                      textInputAction: TextInputAction.next

                    // obscureText: true,
                  ),
                  renderTextFormField(
                      label: '이름',
                      onSaved: (val) {
                        setState(() {
                          name = val!;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return '이름 필수사항입니다.';
                        }
                        if (val.length < 2) {
                          return '이름 2자 이상 입력해주세요!';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next

                  ),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: renderTextFormField(
                            label: '핸드폰 번호',
                            onSaved: (val) {
                              setState(() {
                                phoneId = val!;
                                blueBtn = val.length == 11;
                              });
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return '핸드폰 번호는 필수사항입니다.';
                              }
                              return null;
                            },
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              setState(() {
                                // 여기에서 입력된 값을 반영
                                phoneId = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: blueBtn
                              ? () async {
                            setState(() {
                              showAdditionalInput = true;
                            });
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: blueBtn ? Colors.blue : Colors.grey,
                          ),
                          child: showAdditionalInput
                              ? Text("기다려요")
                              : Text("인증하기"),
                        ),
                      ],
                    ),
                  if (showAdditionalInput)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: renderTextFormField(
                            label: '인증번호 입력',
                            onSaved: (val) {
                              setState(() {
                                phoneId = val!;
                              });
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return '핸드폰 번호는 필수사항입니다.';
                              }
                              return null;
                            },
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // 인증 버튼 클릭 시 수행할 작업
                            setState(() {
                              // 인증 버튼 클릭 시 추가 입력 창 토글
                              showAdditionalInput = !showAdditionalInput;
                            });
                          },
                          child: Text("인증완료"),
                        ),
                      ],
                    ),
                  renderButton(),
                  renderValues(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  renderValues() {
    return Column(
      children: [
        Text(
            'id: $id'
        ),
        Text(
            'email: $email'
        ),
        Text(
          'password: $password',
        ),
        Text(
          'checkpassword: $checkpassword',
        ),
        Text(
          'name: $name',
        ),
        Text('phoneId: $phoneId')
      ],
    );
  }


  Widget renderButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.blue),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          // validation이 성공하면 true가 리턴됩니다.
          setState(() {});
        }
      },
      child: Text(
        '저장하기!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget renderTextFormField({
    required String label,
    required FormFieldSetter<String?> onSaved,
    required FormFieldValidator<String?> validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction? textInputAction,
    ValueChanged<String>? onChanged,
  }) {
    assert(onSaved != null);
    assert(validator != null);

    List<TextInputFormatter>? inputFormatters;

    if (label == '핸드폰 번호') {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LengthLimitingTextInputFormatter(11),
      ];
    }

    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        TextFormField(
          onSaved: onSaved,
          onChanged: onChanged,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}