import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'main.dart';


class ApiPoint{
  var baseUrl = "https://test.deegolabs.kr/mobile/point";

  getPointList(BuildContext context)async{
    var url = "$baseUrl/list?page=1&itemLength=10&searchMode=적립내역";

    try{
      var res = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
      );

      var result = json.decode(res.body);
      print("${result}");
      return result;
    }catch(e){
      print("${e}");
    }
  }
}