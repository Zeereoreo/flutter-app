import 'dart:convert';

import 'package:deego_client/header.dart';
import 'package:deego_client/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> with TickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
    animationDuration: const Duration(milliseconds: 800),
  );

  var qnaList;
  late var _selectedTabIndex = 0;

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }

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
              const Header(),
              Container(
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                  unselectedLabelColor: Colors.white38,
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 16
                  ),
                  indicatorWeight: 3,
                  tabs: [
                    Tab(text: "문의하기"),
                    Tab(text: "내 문의 내역"),
                  ],
                  onTap: (i){
                        if (i == 0) {
                        setState(() {
                        _selectedTabIndex = i;
                        });
                        } else if (i == 1) {
                        setState(() {
                        _selectedTabIndex = i;
                        });
                        getQuestion();
                        }
                  },
                ),
              ),
              Expanded(
                  child:
                  _selectedTabIndex == 0 ? MyQuestionWidget()
                  : ListView.builder(
                      itemCount: qnaList == null ? 0 : qnaList["items"].length,
                      itemBuilder: (c, i) {
                        var qna = qnaList["items"][i];
                        print("아이템빌더 : ${qna["questionDTO"]["title"]}");
                        return Card(
                          color: Colors.white38,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: ExpansionTile(
                            title: Text(qna["questionDTO"]["title"],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),),
                            children: [
                              Container(
                                child: Text("${qna["questionDTO"]["content"]}"),
                              )
                            ],
                          ),
                        );
                      })
              ),
            ],
          ),
        ),
      ),
    );
  }
  getQuestion()async{
    var res = await http.get(Uri.parse("https://test.deegolabs.kr/mobile/qna"),
        headers: {
          "Authorization" : "Bearer ${context.read<AuthStore>().accessToken}"
        }
    );
    var result = jsonDecode(res.body);
    if(res.statusCode == 200){
      print(result);
      setState(() {
        qnaList = result["qnaPage"];
      });
    } else {
      print(res.body);
    }
  }
}

class MyQuestionWidget extends StatefulWidget {
  @override
  _MyQuestionWidgetState createState() => _MyQuestionWidgetState();
}

class _MyQuestionWidgetState extends State<MyQuestionWidget> {
  String _selectedItem = "서비스 이용";
  var _list = ["서비스 이용", "회원 정보", "포인트", "기타"];
  var _qnaTitleController = TextEditingController();
  var _qnaEmailController = TextEditingController();
  var _qnaContentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          qnaName("문의 카테고리 선택"),
          dropList(),
          qnaName("제목"),
          qnacontent("제목을 입력해 주세요.", _qnaTitleController, TextInputType.text),
          qnaName("답변 받을 이메일"),
          qnacontent("이메일을 입력해 주세요.", _qnaEmailController, TextInputType.emailAddress),
          qnaName("문의 내용"),
          Expanded(
            child: TextField(
              controller: _qnaContentController,
              decoration: InputDecoration(
                hintText: "문의 내용을 입력해 주세요.",
                filled: true,
                fillColor: const Color(0xFFF5F7FB),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Color(0xFFF5F7FB)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              expands: true,
              maxLines: null,
                textAlignVertical: TextAlignVertical(y: -1)
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              qnaBtn("취소", Colors.grey ,backNavigator),
              qnaBtn("문의", Color(0xFF00BEFF), postQna),
            ],
          )
        ],
      ),
    );
  }

  Widget dropList(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
      children: [
        Container(
          width: MediaQuery.of(context).size.width/1.11,
          color: Colors.white,
          child: DropdownButton<String>(
            value: _selectedItem,
            items: _list.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      value,
                      textAlign: TextAlign.center, // 가운데 정렬
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedItem = newValue!;
              });
            },
            icon: Icon(Icons.arrow_drop_down), // 드롭다운 아이콘 추가
            iconSize: 24, // 아이콘 크기 조절
            elevation: 8,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            isExpanded: true, // DropdownButton이 화면 전체 너비를 채우도록 설정
          ),
        ),
      ],
    );
  }

  Widget qnacontent(String hint, TextEditingController controller, keyboardType) {
    return Container(
      width: double.infinity,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "$hint",
          filled: true,
          fillColor: const Color(0xFFF5F7FB),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1, color: Color(0xFFF5F7FB)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        maxLines: null,
      ),
    );
  }

  Widget qnaName(String title) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Text("$title",
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
    );
  }

  Widget qnaBtn (String btnText, color, btnAction){

    return Container(
      margin: EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width/2.3,
      height: MediaQuery.of(context).size.height/13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: color,
      ),
      child: TextButton(
        onPressed:
          btnAction
        ,
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(16),
        ),
        child: Center(
          child:Text(
            btnText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  postQna()async{

    var res = await http.post(Uri.parse("https://test.deegolabs.kr/mobile/qna"),
        headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"},
        body: {
          "category": _selectedItem,
          "title": _qnaTitleController.text,
          "content": _qnaContentController.text,
          "email": _qnaEmailController.text,
        }
    );

    if(res.statusCode == 201){
      print("${res.body}");
      setState(() {
        _selectedItem = "서비스 이용";
        _qnaEmailController.clear();
        _qnaTitleController.clear();
        _qnaContentController.clear();
      });
      checkDialog("문의하기 성공", "문의하신 내용은 2~3일 뒤에 작성하신 이메일로 답변 받아보실 수 있습니다.");
    }else {
      print("${res.body}");
      checkDialog("문의하기 실패", "빈 곳이 있는지 확인해주세요.");
    }
  }
  
  backNavigator(){
    Navigator.pop(context);
  }

  void checkDialog(String title, String content){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("확인"))
            ],
          );
        });
  }
}


