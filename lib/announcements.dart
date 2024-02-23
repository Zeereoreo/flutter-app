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

  @override
  void initState() {
    getAnn();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(annList == null){
      return CircularProgressIndicator();
    }

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
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: annList.length,
                      itemBuilder: (context, index) {
                        var item = annList[index];
                        return Card(
                          color: Colors.white38,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: ExpansionTile(
                            title: onText(item["title"]),
                            children: [
                              Container(
                                child: onText(item["content"]),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
               ]
          ),
        ),
      ),
    );
  }

  Widget nullList(){
    return Container(
      width: double.infinity,

    );
  }

  getAnn()async{
    var res = await http.get(Uri.parse("https://test.deegolabs.kr/mobile/notice"),
      headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
    );
    var result = json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        annList = result["noticePage"]["items"];
      });
    }else {
      print("${res.body}");
    }
  }

  Widget onText(String text){
    return Text(text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
