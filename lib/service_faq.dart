import 'dart:convert';

import 'package:deego_client/header.dart';
import 'package:deego_client/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ServiceFAQ extends StatefulWidget {
  const ServiceFAQ({Key? key}) : super(key: key);

  @override
  State<ServiceFAQ> createState() => _ServiceFAQState();
}

class _ServiceFAQState extends State<ServiceFAQ> with TickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: 0,
    animationDuration: const Duration(milliseconds: 800),
  );

  var faqList;


  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getFAQ("서비스이용");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bgimage.png'),
            ),
          ),
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              const Header(),
              Container(
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                  unselectedLabelColor: Colors.white38,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16
                  ),
                  indicatorWeight: 3,
                  tabs: [
                    Tab(text: "서비스"),
                    Tab(text: "회원 정보"),
                    Tab(text: "포인트"),
                    Tab(text: "기타"),
                  ],
                  onTap: (i){
                    switch(i){
                      case 0:
                        getFAQ("서비스");
                        break;
                      case 1:
                        getFAQ("회원정보");
                        break;
                      case 2:
                        getFAQ("포인트");
                        break;
                      case 3:
                        getFAQ("기타");
                        break;
                      default:
                        break;
                    }
                  },
                ),
              ),
              Expanded(
                  child:ListView.builder(
                      itemCount: faqList.length,
                      itemBuilder: (c, i) {
                        var faq = faqList["items"][i];
                        print("아이템빌더 : ${faq}");
                        return ExpansionTile(
                          title: Text(faq["title"]),
                          children: [

                          ],
                        );
                      })
              ),
            ],
          ),
        ),
      ),
    );
  }
 getFAQ(String category)async{
    var res = await http.get(Uri.parse("https://test.deegolabs.kr/mobile/faq?=1?=10?=${category}"),
      headers: {
        "Authorization" : "Bearer ${context.read<AuthStore>().accessToken}"
      }
    );
    var result = jsonDecode(res.body);
    if(res.statusCode == 200){
      print(result);
      setState(() {
        faqList = result["faqPage"];
      });
    } else {
      print(res.body);
    }
 }
}
