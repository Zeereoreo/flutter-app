import 'package:deego_client/api_point.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'header.dart';

class PointSave extends StatefulWidget {
  const PointSave({super.key});

  @override
  State<PointSave> createState() => _PointSaveState();
}

class _PointSaveState extends State<PointSave> {
  dynamic pointList; // 데이터를 저장할 변수

  @override
  void initState() {
    super.initState();
    _fetchPointList(); // 데이터 호출 메서드 호출
  }

  // 데이터를 호출하고 받아오는 메서드
  void _fetchPointList() async {
    try {
      // ApiPoint에서 getPointList 호출하여 데이터 받아오기
      var data = await ApiPoint().getPointList(context);
      // 받아온 데이터를 pointList 변수에 할당하여 UI 업데이트
      setState(() {
        pointList = data;
      });
    } catch (e) {
      print('Error fetching point list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // pointList가 null인 경우 로딩 중 표시
    if (pointList == null) {
      return CircularProgressIndicator();
    }

    // 데이터가 있을 때 UI 렌더링
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
                  itemCount: pointList['page']['items'].length,
                  itemBuilder: (context, index) {
                    var item = pointList['page']['items'][index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: onText(item['deegoName'] ?? "")),
                          onText((item["point"] != null && item["point"] > 0) ? "+${item["point"]}" : (item["point"] ?? "").toString()),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

