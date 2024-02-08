import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_menu.dart';
import 'header.dart';
import 'main.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = '${context.read<userStore>().name}';

    return WillPopScope(
      onWillPop: (){
        return Future(() => false);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bgimage.png'),
          ),
        ),
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                const Header(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: '님, 디고와 함께 \n 지구의 온도를 낮춰보세요!',
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              setBtn(buttonText: '정보 관리',),
                              setBtn(buttonText: '고객 센터',),
                              setBtn(buttonText: '공지 사항',),
                              setBtn(buttonText: '서비스 이용 약관',),
                              setBtn(buttonText: '개인정보 처리 방침',),
                              setBtn(buttonText: '버전 정보',),
                              setBtn(buttonText: '버전 정보',),
                              setBtn(buttonText: '버전 정보',),
                              setBtn(buttonText: '버전 정보',),
                              setBtn(buttonText: '버전 정보',),
                              setBtn(buttonText: '버전 정보',),
                              setBtn(buttonText: '버전 정보',),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomMenu(),
        ),
      ),
    );
  }
}

class setBtn extends StatelessWidget {
  final String buttonText;

  const setBtn({Key? key, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigator.push(context, MaterialPageRoute(builder: () => {}))
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Icon(Icons.arrow_right_outlined),
          ],
        ),
      ),
    );
  }
}
