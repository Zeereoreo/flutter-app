import 'package:deego_client/Wiget/pop_up.dart';
import 'package:deego_client/api_point.dart';
import 'package:deego_client/home.dart';
import 'package:deego_client/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'header.dart';
import 'point.dart';

class PointUsed extends StatefulWidget {
  const PointUsed({super.key});

  @override
  State<PointUsed> createState() => _PointUsedState();
}

class _PointUsedState extends State<PointUsed> {
  var usedList;
  var purchaseList;
  String? prevMonthData;

  @override
  void initState() {
    super.initState();
    // _fetchPointList();
    _purchaseList();
  }


  void _fetchPointList() async {
    try {

      var data = await ApiPoint().getPointUsedList(context);

      setState(() {
        usedList = data;
      });
    } catch (e) {
      // print('Error fetching point list: $e');
    }
  }

  void _purchaseList() async {
    try {

      var data = await ApiPoint().getPointPurchaseList(context);

      setState(() {
        purchaseList = data;
      });
      
      // print("구매목록 ${data}");
    } catch (e) {
      // print('Error fetching point list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (purchaseList == null || purchaseList['purchasedItemPage'] == null || purchaseList['purchasedItemPage']['items'] == null) {
      // purchaseList 또는 해당 항목이 null인 경우 처리
      return CircularProgressIndicator(); // 또는 다른 적절한 처리
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
        title: Text(
          "포인트 전환내역",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: purchaseList['purchasedItemPage']['items'].isEmpty
                  ? Center(
                child: Text(
                  '전환내역이 없습니다.',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: purchaseList['purchasedItemPage']['items'].length,
                itemBuilder: (context, index) {
                  var item = purchaseList["purchasedItemPage"]["items"][index];
                  var createdDate = DateTime.parse(item["createdAt"]);
                  var monthData = DateFormat('yyyy년 MM일').format(createdDate);
                  var dayData = DateFormat('dd').format(createdDate);

                  if (prevMonthData == monthData) {
                    monthData = "";
                  } else {
                    prevMonthData = monthData;
                  }

                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        if (monthData.isNotEmpty)
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "${monthData}",
                              style: TextStyle(fontSize: 14, color: Color(0xFFB3B3B3)),
                            ),
                          ),
                        Row(
                          children: [
                            isBrokenWidget(item["statusCode"]),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text(
                                "${dayData}일",
                                style: TextStyle(fontSize: 16, color: Color(0xFFB3B3B3)),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                child: Text("네이버포인트 전환"),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomPopup(
                                        content: "${item["pinNo"]}",
                                        confirmText: "확인",
                                        title: "핀번호",
                                        onConfirm: () => Navigator.pop(context),
                                        onCancel: () => Navigator.pop(context),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            onText((item["point"] != null && item["point"] > 0) ? "+${item["point"]}" : (item["point"] ?? "").toString()),
                          ],
                        ),
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
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget isBrokenWidget(isBroken) {
    if (isBroken == "07" || isBroken == "02") {
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFF727272),
        ),
        // padding: EdgeInsets.all(1),
        child: Text(
          "사용완료",
          style: TextStyle(
              color: Colors.white,
              fontSize: 12
          ),
        ),
      );
    } else {
      return Container(
        color: Color(0xFFEAF7FF),
        padding: EdgeInsets.all(8),
        child: Text(
          "사용가능",
          style: TextStyle(
              color: Color(0xFF0066FF),
              fontSize: 12
          ),
        ),
      );
    }
  }
}


