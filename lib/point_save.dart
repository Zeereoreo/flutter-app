import 'package:deego_client/api_point.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'header.dart';
import 'horizontaldasheddivider.dart';
import 'main.dart';
import 'point.dart';

class PointSave extends StatefulWidget {
  const PointSave({super.key});

  @override
  State<PointSave> createState() => _PointSaveState();
}

class _PointSaveState extends State<PointSave> {
  dynamic pointList;
  String? prevMonthData;

  @override
  void initState() {
    super.initState();
    _fetchPointList();
  }


  void _fetchPointList() async {
    try {

      var data = await ApiPoint().getPointList(context);

      setState(() {
        pointList = data;
      });
    } catch (e) {
      // print('Error fetching point list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    if (pointList == null) {
      return CircularProgressIndicator();
    }


    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Point(accessToken: context.read<AuthStore>().accessToken)));
          },
        ),
        centerTitle: true,
        title: Text("포인트 적립내역",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),

      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: pointList['page']['items'].length,
                itemBuilder: (context, index) {
                  var item = pointList['page']['items'][index];
                  var createdDate = DateTime.parse(item["createdDateFormat"]);
                  var monthData = DateFormat('yyyy년 MM일').format(createdDate);
                  var dayData = DateFormat('dd').format(createdDate);
                  // print("${item}");
                  // print("달 : ${monthData}");
                  // print("요일 : ${dayData}");

                  if (prevMonthData == monthData) {
                    monthData = "";
                  } else {
                    prevMonthData = monthData;
                  }

                  return Container(
                    padding: EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black, width: 1),
                    // ),
                    child: Column(
                      children: [
                        if (monthData.isNotEmpty)
                          Container(
                          // width: ,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          child: Text("${monthData}",
                            style: TextStyle(fontSize: 14,color: Color(0xFFB3B3B3)),)),
                      Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("${dayData}일",style: TextStyle(fontSize: 16,color: Color(0xFFB3B3B3)),)),
                            Expanded(child: Text(item['deegoName'] ?? "",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)),
                            onText((item["point"] != null && item["point"] > 0) ? "+${item["point"]}P" : (item["point"] ?? "").toString()),
                          ],
                        ),
                        HorizontalDashedDivider(thickness: 1,length: 3,color: Color(0xFFDCDCDC),indent: 20,endIndent: 20,),

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

  Widget onText(String text){
    return Text(text,
      style: TextStyle(
        color: Color(0xFF0066FF),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

