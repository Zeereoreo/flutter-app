
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:deego_client/bottom_menu.dart';
import 'package:deego_client/footer.dart';
import 'package:deego_client/header.dart';
import 'package:flutter/material.dart';
import 'package:deego_client/point.dart';
import 'package:provider/provider.dart';
import 'main.dart';



class Home extends StatefulWidget {
  const Home({Key? key, required this.accessToken}) : super(key: key);
  final String accessToken;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String id = "";
  int point = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPoint();
  }

  @override
  Widget build(BuildContext context) {

    // print("Access Token in Home: ${widget.accessToken}");
    // getPoint();
    // print(context.read<pointStore>().getPoint(widget.accessToken));
    var name = '${context.read<userStore>().name}';
    var currentPoint = '${context.read<pointStore>().current}';

    return FutureBuilder(
      future: getPoint(),
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const Header(),
                   Container(
                     decoration: BoxDecoration(
                         border: Border.all(color: Colors.black)
                     ),
                     margin: EdgeInsets.only(top:10,left: 10,right: 10),
                     alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                          text: name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                          children: const <TextSpan>[
                            TextSpan(text: '님, 디고와 함께 \n 지구의 온도를 낮춰보세요!',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20)
                            )
                          ]
                      ),

                    ),
                  ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Color(0x5000BEFF),
                            height: MediaQuery.of(context).size.height/6,
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: MediaQuery.of(context).size.height/18,
                                  child: Text('현재 포인트',style: TextStyle(color: Colors.white,),),
                                ),
                                Container(
                                  // margin: EdgeInsets.all(10),
                                  height: MediaQuery.of(context).size.height/18,
                                  child: Text('$currentPoint P', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height/5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Point(accessToken: accessToken,)));
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: EdgeInsets.all(16),
                          ),
                          child: const Center(
                            child: Text(
                              '적립 내역',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFCCCCCC),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Point()));
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: EdgeInsets.all(16),
                          ),
                          child: const Center(
                            child: Text(
                              '포인트 사용하러 가기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFCCCCCC),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text('즐겨찾는 디고')),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/4,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Text('즐겨찾는 디고가 없습니다.'),
                  ),
                ),

              ],
            ),
          ),
          bottomNavigationBar: BottomMenu(),
        );
      }
    );
  }

  getPoint() async {

    final url = Uri.https("test.deegolabs.com:3000", "/mobile/point");

    final response = await http.get(
      url,
      headers : {
        "Authorization" : "Bearer ${context.read<AuthStore>().accessToken}"
      }
    );

    if(response.statusCode == 200){
      final Map<String, dynamic> responseData = json.decode(response.body);
      context.read<pointStore>().current = responseData["current"];


    }
  }
}