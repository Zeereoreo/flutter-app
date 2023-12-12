import 'package:deego_client/bottom_menu.dart';
import 'package:deego_client/footer.dart';
import 'package:deego_client/header.dart';
import 'package:flutter/material.dart';
import 'package:deego_client/point.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var a = 'login아이디';

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
                      text: a,
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
                              child: Text('0 P', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Point()));
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Point()));
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
      bottomNavigationBar: const BottomMenu(),
    );
  }
}