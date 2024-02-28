
import 'dart:convert';

import 'package:deego_client/point_save.dart';
import 'package:deego_client/point_used.dart';
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
  var favoriteList;

  @override
  void initState() {
    super.initState();
    getDeegoFavorite();
  }

  @override
  Widget build(BuildContext context) {

    var name = '${context.read<userStore>().name}';
    var currentPoint = '${context.read<pointStore>().current}';
    print("access :${context.read<AuthStore>().accessToken}");


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
              title: Image.asset(
                'assets/images/deego_logo.png', // 이미지 경로
                width: MediaQuery.of(context).size.width * 0.3, // 이미지 너비 조절
                height: MediaQuery.of(context).size.height * 0.9, // 이미지 높이 조절
                fit: BoxFit.contain, // 이미지를 AppBar에 맞게 조절
              ),
            ),
            body: Container(
              color: Color(0xFFF8F8F8),
              // padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Container(
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
                    padding: const EdgeInsets.all(20),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black, width: 1),
                    // ),
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
                        color: Colors.white,
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.black, width: 1),
                        // ),
                        child: Column(
                          children: [
                            Container(
                              child: Text('즐겨찾는 디고',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18
                                ),
                              ),
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.topLeft,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 4,
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)
                                // ),
                                child: favoriteList != null && favoriteList.isNotEmpty
                                    ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: favoriteList.length,
                                      itemBuilder: (context, index) {
                                        var item = favoriteList[index];
                                        return Container(
                                          child: Text(item["name"]),
                                        );
                                  },
                                )
                                    : const Center(
                                      child: Text(
                                      "즐겨찾는 디고가 없습니다.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ),

                ],
              ),
            ),
            bottomNavigationBar: BottomMenu(),
          ),
        );
      }

      getDeegoFavorite()async{
        var res = await http.get(Uri.parse("https://test.deegolabs.kr/mobile/deego/favorite"),
          headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"}
        );

        if(res.statusCode == 200){
          var list = jsonDecode(res.body);
          setState(() {
            favoriteList = list["favoriteDeegoPage"]["items"];
            print(favoriteList);
          });
        }
      }

}