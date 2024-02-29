import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'header.dart';
import 'main.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  var annList;
  bool isLoading = true; // 데이터 로딩 중 여부를 나타내는 변수

  @override
  void initState() {
    getAnn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (annList == null || annList.isEmpty) {
        return nullList(); // 데이터가 없을 때 nullList 위젯을 반환
      } else {
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
            title: Text("공지사항",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
          ),
          body: Container(
            color: Color(0xFFF8F8F8),
            child: Column(
              children: [
                // const Header(),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: annList.length,
                    itemBuilder: (context, index) {
                      var item = annList[index];
                      return Card(
                        color: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ExpansionTile(
                          title: Text(item["title"],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              color: Colors.white,
                              child: Text(item["content"],style: TextStyle(fontSize: 16,color: Colors.black)),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  Widget nullList() {
    return Center(
      child: Container(
        width: double.infinity,
        child: Text(
            "디고의 기본 이용 안내는 고객센터 또는 서비스 이용 약관, 개인정보 처리방침 메뉴를 참고해주세요.",
            style: TextStyle(fontSize: 18,color: Colors.black)
        ),
      ),
    );
  }

  Future<void> getAnn() async {
    var res = await http.get(
      Uri.parse("https://test.deegolabs.kr/mobile/notice"),
      headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
    );
    var result = json.decode(res.body);
    if (res.statusCode == 200) {
      setState(() {
        annList = result["noticePage"]["items"];
        isLoading = false; // 데이터 로딩이 완료되었음을 나타내는 변수를 false로 설정
      });
    } else {
      print("${res.body}");
    }
  }

  Widget onText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
