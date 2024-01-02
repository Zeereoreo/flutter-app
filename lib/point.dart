
import 'dart:convert';

import 'package:deego_client/header.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'bottom_menu.dart';
import 'main.dart';

class Point extends StatefulWidget {
  const Point({super.key, required this.accessToken}) : super() ;
  final String accessToken;

  @override
  State<Point> createState() => _PointState();
}


class _PointState extends State<Point> {
   var shopList ;
  // late List<Map<String, dynamic>> shopList;

  @override
  void initState() {
    super.initState();
    getShop(); // 위젯이 초기화될 때 한 번만 호출
  }

  @override
  Widget build(BuildContext context) {

    if (shopList == null) {
      // 초기화되지 않았다면 로딩 또는 기본 화면을 표시
      return CircularProgressIndicator(); // 예시로 로딩 표시
    }

    var currentPoint = '${context.read<pointStore>().current}';


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        margin: EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                     Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
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
                                Container(
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.height/6,
                                  // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                                  child: Lottie.asset(
                                      "assets/lottie/point_lottie.json",
                                      fit:BoxFit.fill),
                                )
                              ],
                            ),
                          ),

                      ],
                    ),
                  ),
                  Container(

                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                          child:
                           Column(
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
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height/10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/3,
                              height: MediaQuery.of(context).size.height/15,
                              child: TextButton(
                                onPressed: () {},
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
                            Container(
                              width: MediaQuery.of(context).size.width/3,
                              height: MediaQuery.of(context).size.height/15,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  padding: EdgeInsets.all(16),
                                ),
                                child: const Center(
                                  child: Text(
                                    '구매 내역',
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
                      ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                    child: ListView.builder(
                      shrinkWrap: true,
                      // itemExtent: MediaQuery.of(context).size.height / 10,
                      itemCount: shopList.length,
                      itemBuilder: (c, i){
                        var item = shopList[i];
                        return Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                                width: MediaQuery.of(context).size.width/4,
                                height: MediaQuery.of(context).size.height/2,
                                child: Image.network("${item["image"]}",fit: BoxFit.cover,)
                                ,
                              ),
                              title: Container(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                                  child:  Container(
                                      child: Column(
                                        children: [
                                          Text("${item["name"]}"),
                                          ElevatedButton(
                                              onPressed: (){
                                                showDialog(context: context, builder: (context){
                                                  return Dialog(
                                                    child: Purchase(item: item,),
                                                  );
                                                });
                                          }, child: Text("구매하기"))
                                        ],
                                      ),
                                    ),
                              ),
                            ),
                        );
                      })
                  ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }

  getShop()async{
    var response = await http.get(Uri.parse("https://test.deegolabs.com:3000/mobile/shop/item/list"),
        headers:
        {
          "Authorization": "Bearer ${context.read<AuthStore>().accessToken}"
        });
    var itemList = jsonDecode(response.body);
    if(response.statusCode == 200) print("성공");
    else {
      print(response.statusCode);
      print("실패");
    };
    setState(() {
      shopList = itemList["shopItemPage"]["items"];
    });
    // print(shopList[2]);
  }
}



class Purchase extends StatefulWidget {
  final Map<String, dynamic> item;

  const Purchase({Key? key, required this.item}) : super(key: key);

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  @override
  Widget build(BuildContext context) {
    print("${widget.item["id"]}");
    print("${context.read<AuthStore>().accessToken}");
    getPoint()async{

      var response =  await http.get(Uri.parse("https://test.deegolabs.com:3000/mobile/shop/item/${widget.item["id"]}/purchase"),
          headers:
          {
            "Authorization": "Bearer ${context.read<AuthStore>().accessToken}"
          });

      var itemList = jsonDecode(response.body);
      if(response.statusCode == 200) {
        print("성공");

      }
      else {
        print(response.statusCode);
        print(response.body);
        print("실패");
      };
      setState(() {

      });
    }

    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width/2,
      height: MediaQuery.of(context).size.height/3,
      child: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/4.8,
              decoration: BoxDecoration(
                color: Colors.grey
              ),
              child: Center(child: Container(
                  child: Text("${widget.item["name"]}\n 구매하시겠습니까??", style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),)
              )
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){
                    showDialog( context: context,
                    builder: (context) {
                          return AlertDialog(
                          title: Text("포인트 등록"),
                          content: Text("구매하신 포인트는 한달 안에 등록해주셔야 사용 가능합니다 \n 동의하시고 진행하시겠습니까??"),
                          actions: [
                            TextButton(onPressed: (){
                              getPoint();
                            }, child: Text("동의")),
                            TextButton(
                              onPressed: () {
                              Navigator.pop(context);
                              },
                              child: Text("닫기"),
                              ),
                                ],
                                );
                                },
                                );
                                },
                                  child: Text("다음으로"),
                      ),
                  TextButton(onPressed: (){
                      Navigator.pop(context);
                  }, child: Text("취소하기"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Confirm extends StatelessWidget {
  const Confirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width/10,
      height: MediaQuery.of(context).size.height/3,
      color: Colors.black,
      child: Column(
        children: [
          Text("ㅎㅇ")
        ],
      ),
    );
  }
}
