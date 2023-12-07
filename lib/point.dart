import 'package:deego_client/earn.dart';
import 'package:deego_client/header.dart';
import 'package:flutter/material.dart';

class Point extends StatelessWidget {
  const Point({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      margin: EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text('현재 보유 포인트'),
                        TextButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Earn()), // Earn 클래스의 인스턴스 반환
                          );
                        },
                            child: const Text('적립 내역',style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFDFDFDF),
                          decoration: TextDecoration.underline,
                        ),))

                      ],
                    )),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 100,
                  // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                  child:
                    const Text('0', style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,

                ),),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                        child:
                        const Column(
                          children: [
                            Text('총 적립 포인트 : 0',
                              style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFDFDFDF),),),
                            Text('사용 완료 포인트 : 0',
                              style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFDFDFDF),)
                            ),
                          ],
                        ),
                      ),
                    Container()
                    ],
                )
              ],
            ),
          ),
          Container(
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                  height: 150, width: 200,
                    child : (
                        Text('사진 들어갈 자리'))),
                        Text('시흥 화폐 시루'),
                        Text('1만원권'),
              ],
            ),
            // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          ),
          Container(
            height: 100,
            // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          ),
        ],
      ),
    );
  }
}
