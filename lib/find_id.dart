import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FindId extends StatefulWidget {
  const FindId({super.key});

  @override
  State<FindId> createState() => _FindIdState();
}

class _FindIdState extends State<FindId> {
  String name = "";
  String phone = "";
  bool _nameError = false;
  bool _phoneError = false;
  String id = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/bgimage.png'), // 배경 이미지
      ),),
      child: Scaffold(
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
                    TextField(
                      onChanged: (text){
                        setState(() {
                          _phoneError = text.length < 10 || text.length > 12 ;
                          phone = text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: '핸드폰 번호',
                        hintText: "핸드폰 번호를 입력해 주세요.",
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
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){

                    }, child: Text("아이디 찾기"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_nameError && !_phoneError ?
                        Color(0xFF00BEFF) :
                        Color(0xFFB2EBFC)
                      ),
                    ),
                    Text(id,style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  findId()async{
    var res = await http.post(Uri.parse("https://test.deegolabs.kr/mobile/auth/id"),
      body: {
        "name" : name,
        "phoneId" : phone,
      }
    );
    var userId = jsonDecode(res.body);
    if(res.statusCode == 200) {
      setState(() {
        userId = id;
      });
    }else{
      print(res.body);
    }
  }
}
