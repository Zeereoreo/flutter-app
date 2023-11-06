import 'package:flutter/material.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var a = 'login아이디';

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             Container(
               decoration: BoxDecoration(
                   border: Border.all(color: Colors.black)
               ),
               margin: EdgeInsets.only(top:40,left: 10,right: 10),
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
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                  },
                    child: Text('적립 내역',style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFCCCCCC),
                          decoration: TextDecoration.underline,
                        ),),
                      ),
                ],
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
                      width: 200,
                      color: Color(0x5000BEFF),
                      height: 150,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
                            child: Text('현재 포인트',style: TextStyle(color: Colors.white,),),
                          ),
                          Container(
                            // margin: EdgeInsets.all(10),
                            height: 60,
                            child: Text('0', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Container(
                      width: 200,
                      color: Color(0x5000BEFF),
                      height: 150,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
                            child: Text('누적 포인트'),
                          ),
                          Container(
                            // margin: EdgeInsets.all(10),
                            height: 60,
                            child: Text('0', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
              margin: EdgeInsets.only(left: 15),
              child: Text('즐겨찾는 디고')),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
              ),
              child: Text('즐겨찾는 디고가 없습니다.'),
            ),
          ),
          // Container(
          //   height: 80,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       TextButton(
          //         onPressed: () {
          //
          //         },
          //         style: TextButton.styleFrom(
          //           foregroundColor: Colors.black, padding: EdgeInsets.all(20),
          //           backgroundColor: Colors.white,
          //         ),
          //         child: Text('카메라 모드로 페트병을 찍어', style: TextStyle(fontSize: 15),),
          //       ),
          //       ElevatedButton(
          //         onPressed: () {
          //
          //         },
          //         style: ElevatedButton.styleFrom(
          //           shape: CircleBorder(),
          //           padding: EdgeInsets.all(35),
          //         ),
          //         child: Text('적립하기'),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}