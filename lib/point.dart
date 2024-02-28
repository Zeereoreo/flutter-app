
import 'dart:convert';
import 'dart:math';

import 'package:deego_client/header.dart';
import 'package:deego_client/point_save.dart';
import 'package:deego_client/point_used.dart';
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
    var spentsPoint = '${context.read<pointStore>().spents}';
    var name = '${context.read<userStore>().name}';


    return WillPopScope(
      onWillPop: (){
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: SizedBox(), // 뒤로가기 버튼 제거
          centerTitle: true, // 제목 가운데 정렬
          title: Text("포인트 전환",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)
        ),
        body: Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          // margin: EdgeInsets.all(10),
          color: Color(0xFFF8F8F8),

          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Header(),
              Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),

                width: double.infinity,
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black, width: 1),
                // ),
                // height: MediaQuery.of(context).size.height/6,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Color(0xFF0066FF)),
                        children: const <TextSpan>[
                          TextSpan(
                            text: '님',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Text("디고와 함께 지구의 온도를 낮춰보세요!",
                      style: TextStyle( fontSize: 16, color: Colors.black),

                    )
                  ],
                ),
              ),
              Container(
                padding : EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF0066FF),
                        ),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.06,
                        // margin: EdgeInsets.all(10),
                        // alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.only(top: 10),
                                // alignment: Alignment.topLeft,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 18,
                                child: Text('잔여포인트',
                                  style: TextStyle(color: Colors.white,fontSize: 16),),
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.all(10),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 18,
                              child: Text('$currentPoint P', style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding : EdgeInsets.only(left: 20,right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,
                        ),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.06,
                        // margin: EdgeInsets.all(10),
                        // alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.only(top: 10),
                                // alignment: Alignment.topLeft,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 18,
                                child: Text('사용 포인트',
                                  style: TextStyle(color: Colors.white,fontSize: 16),),
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.all(10),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 18,
                              child: Text('$spentsPoint P', style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black, width: 1),
                // ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.17,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          // border: Border.all(color: Colors.black, width: 1),
                          color: Colors.white,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PointSave()));
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16),
                              backgroundColor: Colors.white,
                              elevation: 2
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '적립 내역',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  'assets/images/used_image.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // 각 버튼 사이에 간격 추가
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          // border: Border.all(color: Colors.black, width: 1),
                          color: Colors.white,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<footerStore>().tab = 2;
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Point(accessToken: context.read<AuthStore>().accessToken,)));
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16),
                              backgroundColor: Colors.white,
                              elevation: 2
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '포인트 전환내역',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  'assets/images/point_image.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.2,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Image.asset("assets/images/naver_Icon.png",width: MediaQuery.of(context).size.width * 0.05, fit: BoxFit.cover,),
                            SizedBox(width: 10,),
                            Text("네이버 포인트로 전환하기",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            // itemExtent: MediaQuery.of(context).size.height / 10,
                            itemCount: shopList.length,
                            itemBuilder: (c, i){
                              var item = shopList[i];
                              print("$item");
                              return Container(
                                margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFE0E0E0), width: 1.5),
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${item["name"]}",
                                        style: TextStyle(
                                          color: item["name"] == "네이버페이" ? Colors.green : Colors.black, // "네이버페이"일 때만 초록색, 그 외에는 검정색
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      ElevatedButton(
                                        onPressed: (){
                                          showDialog(context: context, builder: (context){
                                            return Dialog(
                                              child: Purchase(item: item,),
                                            );
                                          });
                                        }, child: Image.asset("assets/images/point_arrow.png", fit: BoxFit.cover, width: 20,),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomMenu(),
      ),
    );
  }

  getShop()async{
    var response = await http.get(Uri.parse("https://test.deegolabs.kr/mobile/shop/item/list"),
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

  dynamic pin = ''; // PIN을 저장하는 변수

  @override
  Widget build(BuildContext context) {
    print("${widget.item["id"]}");
    print("${context.read<AuthStore>().accessToken}");
    getPoint()async{

      var response =  await http.post(Uri.parse("https://test.deegolabs.kr/mobile/shop/item/${widget.item["id"]}/purchase"),

          headers:
          {
            "Authorization": "Bearer ${context.read<AuthStore>().accessToken}"
          });

      var itemList = jsonDecode(response.body);
      if(response.statusCode == 200) {
        print("성공");
        var result = jsonDecode(response.body);
        print("$result");
        setState(() {
          pin = result; // 응답에서 PIN 값을 추출하여 저장
        });
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
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("${widget.item["name"]}\n 구매하시겠습니까??",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        Text("${widget.item["description"]}")
                      ]
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("포인트 구매"),
                            content: Text(
                                "구매하신 포인트는 한달 안에 등록해주셔야 사용 가능합니다 \n 동의하시고 진행하시겠습니까??"),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await getPoint();
                                  // 구매 성공 시 PIN을 받아옴
                                  getUserPoint(context);
                                  Navigator.pop(context);
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      title: Text("네이버포인트 쿠폰번호"),
                                      content: Text(
                                        "$pin"
                                      ),
                                      actions: [
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text("확인")),
                                        TextButton(onPressed: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PointUsed()));

                                        }, child: Text("구매 내역"))
                                      ],
                                    );
                                  });
                                },
                                child: Text("동의"),
                              ),
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
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("취소하기"),
                  )
                ],
              ),
            ),
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

Future<void> getUserPoint(BuildContext context) async {
  print("context : ${context}");
  final url = Uri.https("test.deegolabs.kr", "/mobile/point");
  print("header : ${context.read<AuthStore>().accessToken}");
  final response = await http.get(
      url,
      headers : {
        "Authorization" : "Bearer ${context.read<AuthStore>().accessToken}"
      }
  );

  print("body :${response.body}");

  if(response.statusCode == 200){
    print("포인트불러오기성공");
    final Map<String, dynamic> responseData = json.decode(response.body);
    context.read<pointStore>().current = responseData["current"];
    print("point :${context.read<pointStore>().current}");

  } else{

    print("실패 :${response.body}");
  }
}
