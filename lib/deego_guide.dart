import 'package:flutter/material.dart';

class DeegoGuide extends StatefulWidget {
  const DeegoGuide({super.key});

  @override
  State<DeegoGuide> createState() => _DeegoGuideState();
}

class _DeegoGuideState extends State<DeegoGuide> {
  @override
  Widget build(BuildContext context) {
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
        title: Text("디고 가이드",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GuideStep("STEP 01"),
              SizedBox(height: 10,),
              GuideTitle("현재 지역에서 가까운 디고 배출함을 찾아보세요!"),
              SizedBox(height: 10,),
              GuideContent("지도탭을 눌러서 디고 위치를 확인해보세요."),
              SizedBox(height: 10,),
              Image.asset("assets/images/deego_guide_nav.png",fit: BoxFit.cover,width: double.infinity,),
              SizedBox(height: 10,),
              Image.asset("assets/images/deego_guide_map.png",fit: BoxFit.cover,width: double.infinity,),
              SizedBox(height: 10,),
              Image.asset("assets/images/deego_guide_list.png",fit: BoxFit.cover,width: double.infinity,),
              SizedBox(height: 40,),
              GuideStep("STEP 02"),
              SizedBox(height: 10,),
              GuideTitle("디고 배출함에 페트병을 안내에 따라 배출해주세요."),
              SizedBox(height: 10,),
              GuideContent("캔, 유리병 제외 페트병만 배출이 가능합니다.\n (액체가 없는 페트병만 가능)"),
              SizedBox(height: 10,),
              Image.asset("assets/images/deego_guide_bin.png",fit: BoxFit.cover,width: double.infinity,),
              SizedBox(height: 40,),
              GuideStep("STEP 03"),
              SizedBox(height: 10,),
              GuideTitle("적립된 포인트로 다양한 보상을 누려보세요!"),
              SizedBox(height: 10,),
              GuideContent("포인트탭을 눌러서 네이버포인트로 전환합니다. \n주어진 핀번호를 받고 난 뒤 네이버에 등록하면 끝!"),
              SizedBox(height: 10,),
              Image.asset("assets/images/deego_guide_point.png",fit: BoxFit.cover,width: double.infinity,),
            ],
          ),
        ),
      ),
    );
  }

  Widget GuideStep(String title){
    return Text(
      title,
      style: TextStyle(
        color: Color(0xFF369BEF),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget GuideTitle(String title){
    return Text(
      title,
      style: TextStyle(
          color: Color(0xFF141414),
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Widget GuideContent(String title){
    return Text(
      title,
      style: TextStyle(
          color: Color(0xFF0E0E0E),
          fontSize: 14,
          // fontWeight: FontWeight.normal
      ),
    );
  }
}
