import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'main.dart';


class ApiPoint{
  var pointUrl = "https://backend.deegolabs.com/mobile/point";
  var shopUrl = "https://backend.deegolabs.com/mobile/shop";

  getPointList(BuildContext context)async{
    var url = "$pointUrl/list?page=1&itemLength=10&searchMode=적립내역";

    try{
      var res = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
      );

      var result = json.decode(res.body);
      // print("${result}");
      return result;
    }catch(e){
      // print("${e}");
    }
  }

  getPointUsedList(BuildContext context)async{
    var url = "$pointUrl/list?page=1&itemLength=10&searchMode=사용내역";

    try{
      var res = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
      );

      var result = json.decode(res.body);
      // print("${result}");
      return result;
    }catch(e){
      // print("${e}");
    }
  }

  getPointPurchaseList(BuildContext context)async{
    var url = "$shopUrl/item";

    try{
      var res = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
      );

      var result = json.decode(res.body);
      // print("결과 값 : ${result}");
      return result;
    }catch(e){
      // print("에러 값 : ${e}");
    }
  }
}