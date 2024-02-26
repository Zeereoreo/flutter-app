
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
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bgimage.png'),
              ),
            ),
            child: Scaffold(
              body: Container(
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.black)
                // ),
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Header(),
                    Container(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)
                      // ),
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                            text: name,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.white),
                            children: const <TextSpan>[
                              TextSpan(text: '님, 디고와 함께 \n 지구의 온도를 낮춰보세요!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal, fontSize: 20,color: Colors.white)
                              )
                            ]
                        ),

                      ),
                    ),
                    Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.white),
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xFF00BEFF),
                                ),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 7,
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 18,
                                      child: Text('현재 포인트',
                                        style: TextStyle(color: Colors.white,fontSize: 20),),
                                    ),
                                    Container(
                                      // margin: EdgeInsets.all(10),
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 18,
                                      child: Text('$currentPoint P', style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),),
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
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)
                      // ),
                      width: double.infinity,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 14,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2.3,
                            height: MediaQuery.of(context).size.height/13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey,
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PointSave()));
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(16),
                              ),
                              child: const Center(
                                child: Text(
                                  '적립 내역',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width/2.3,
                            height: MediaQuery.of(context).size.height/13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Color(0xFF00BEFF),
                            ),
                            child: TextButton(
                              onPressed: () {
                                context.read<footerStore>().tab = 2;
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Point(accessToken: context.read<AuthStore>().accessToken,)));
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(16),
                              ),
                              child: const Center(
                                child: Text(
                                  '포인트 전환',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 25),
                        child: Text('즐겨찾는 디고',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20
                          ),
                        )),
                    Align(
                      alignment: Alignment.center,
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
                            : Center(
                              child: Text(
                                "즐겨찾는 디고가 없습니다.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              bottomNavigationBar: BottomMenu(),
            ),
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