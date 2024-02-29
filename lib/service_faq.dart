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
    getFAQ("서비스 이용");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true, // 제목 가운데 정렬
        title: Text("FAQ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),

      ),
      body: Container(
        child: Column(
          children: [
            // const Header(),
            Container(
              child: TabBar(
                controller: tabController,
                labelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                unselectedLabelColor: Colors.grey,
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
                      getFAQ("서비스 이용");
                      break;
                    case 1:
                      getFAQ("회원 정보");
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
                    itemCount: faqList == null ? 0 : faqList["items"].length,
                    itemBuilder: (c, i) {
                      var faq = faqList["items"][i];
                      print("아이템빌더 : ${faq}");
                      return Card(
                        color: Colors.white38,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ExpansionTile(
                          title: Text(faq["title"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                          children: [
                            Container(
                              child: Text("${faq["content"]}"),
                            )
                            ],
                        ),
                      );
                    })
            ),
          ],
        ),
      ),
    );
  }
 getFAQ(String category)async{
    var res = await http.get(Uri.parse("https://test.deegolabs.kr/mobile/faq?page=1&itemLength=10&category=${category}"),
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
