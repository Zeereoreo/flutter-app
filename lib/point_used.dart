import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PointUsed extends StatefulWidget {
  const PointUsed({super.key});

  @override
  State<PointUsed> createState() => _PointUsedState();
}

class _PointUsedState extends State<PointUsed> {

  @override
  void initState() {
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
                  Expanded(child: Container(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (c,i){

                        }),
                  )
                  )
                ],
              ),
            )
        )
    );
  }

  getPointSave()async{
    var res = await http.get(Uri.parse("http://test.deegolabs.kr/mobile/point"));
  }
}
