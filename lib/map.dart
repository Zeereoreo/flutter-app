import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:deego_client/Wiget/pop_up.dart';
import 'package:deego_client/location.dart';
import 'package:deego_client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'bottom_menu.dart';
import 'main.dart';

class NaverMapApp extends StatefulWidget {
  const NaverMapApp({Key? key}) : super(key: key);

  @override
  State<NaverMapApp> createState() => _NaverMapAppState();
}

class _NaverMapAppState extends State<NaverMapApp> {
  double? initialLat;
  double? initialLng;
  var deegoList;
  var isFavorite = false;
  List favoriteSerialNumbers = [];

  @override
  void initState() {
    super.initState();
    getInitialLocation();
    getDeego();
    getDeegoFavorite();
  }

  void getInitialLocation() async {

    Location location = Location();
    await location.getCurrentLocation();
    // print(location.latitude);
    // print(location.longitude);
    setState(() {
      initialLat = location.latitude;
      initialLng = location.longitude;
    });
    // print(initialLat);
    // print(initialLng);
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // setState(() {
    //   initialLat = position.latitude;
    //   initialLng = position.longitude;
    //
    // });
  }




  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();

    return
       WillPopScope(
         onWillPop: (){
           return Future(() => false);
         },
         child: Scaffold(
           body: Column(
             children: [Expanded(
               child: NaverMap(
                 options: NaverMapViewOptions(
                   initialCameraPosition: NCameraPosition(
                     target: initialLat != null && initialLng != null
                         ? NLatLng(initialLat!, initialLng!) // 널 값이 아닐 때
                         : const NLatLng(37.568963, 126.646476), // 널 값일 때 하드코딩한 좌표
                     zoom: 18,
                     bearing: 0,
                     tilt: 0,
                   ),
                  mapType: NMapType.basic,   // 맵 스타일
                  liteModeEnable: true,   // 경량모드
                  indoorEnable: true,             // 실내 맵 사용 가능 여부
                  locationButtonEnable: true,    // 내 위치 표시 버튼
                  consumeSymbolTapEvents: false,  // 심볼 탭 이벤트 소비 여부
                  zoomGesturesEnable: true,       // 줌 설정
                  rotationGesturesEnable: false, // 회전
                  tiltGesturesEnable: false,  // 기울기
                  minZoom: 10, // default is 0
                  maxZoom: 20, // default is 21
                  extent: NLatLngBounds(          // 한반도 내로 제한
                    southWest: NLatLng(31.43, 122.37),
                    northEast: NLatLng(44.35, 132.0),
                  ),
                ),
                onMapReady: (controller) async {
                  getInitialLocation();
                  NCameraUpdate.withParams(
                    zoom: 20,
                  );
                  // final marker1 = NMarker(id: '1', position: (37.568963,126.646476));
                  mapControllerCompleter.complete(controller);  // Completer에 지도 컨트롤러 완료 신호 전송
                  // getLocation();
                  // log("onMapReady", name: "onMapReady");
                      final marker = NMarker(
                      id: 'test',
                      position:
                      const NLatLng(37.568963, 126.646476));
                      final marker1 = NMarker(
                      id: 'test1',
                      position:
                      const NLatLng(37.606932467450326, 127.05578661133796));
                      controller.addOverlayAll({marker, marker1});

                      final onMarkerInfoWindow =
                      NInfoWindow.onMarker(id: marker.info.id, text: "디고 빈");
                      marker.openInfoWindow(onMarkerInfoWindow);
                      },              // 지도 준비 완료 시 호출되는 콜백 함수
          ),
             ),
             Container(
               width: double.infinity,
               height: MediaQuery.of(context).size.height/3,
               color: Colors.white,
               padding: EdgeInsets.all(20),
               child: Container(
                 child: deegoList != null ? ListView.builder(
                   padding: EdgeInsets.zero,
                   shrinkWrap: true,
                   itemCount: deegoList.length,
                   itemBuilder: (c, i) {
                     var item = deegoList[i];
                     var serieal = item["serialNumber"];
                     bool isFavoriteItem = favoriteSerialNumbers.any((element) =>
                     element["deego"]["serialNumber"] == serieal);
                     // print("$serieal");
                     // print("$item");
                     return Container(
                       decoration: BoxDecoration(
                         border: Border.all(width: 1, color: Color(0xFFE0E0E0))
                       ),
                       margin: EdgeInsets.all(5),
                       padding: EdgeInsets.only(left: 10),
                       child: Row(
                         children: [
                           Image.asset("assets/images/deego_image.png",fit: BoxFit.cover,),
                           Expanded(
                             child: Container(
                               padding: EdgeInsets.all(10),
                                 // decoration: BoxDecoration(
                                 //   border: Border.all(width: 1,)
                                 // ),
                                 child:
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                     Text("${item["name"]}", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                                     // SizedBox(height: ,),
                                     Text("${item["deegoLocationDTO"]["location"]}", style: TextStyle(color: Color(0xFFB3B3B3), fontSize: 14),),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         isBrokenWidget(item["isBroken"]),
                                         TextButton(onPressed: (){
                                           patchFavorite(serieal);
                                           // print("클릭");
                                         },
                                           child: isFavoriteItem ? Icon(Icons.star,color: Color(0xFFFFD014),size: 40,) : Icon(Icons.star,color: Color(0xFFEBEBEB),size: 40,),
                                           style: ElevatedButton.styleFrom(
                                               backgroundColor: Colors.white,
                                               elevation: 0,
                                             shape: CircleBorder(),
                                             // side: BorderSide(width: 2, color: Colors.grey),
                                           ),
                                         )
                                       ],
                                     )
                                   ],
                                 )
                             ),
                           )
                         ],
                       )
                     );
                   },
                 ) : CircularProgressIndicator(), // deegoList가 null인 경우 로딩 인디케이터를 표시
               ),
             )
             ]
           ),

          bottomNavigationBar: const BottomMenu(),
      ),
       );
  }
  getDeego()async{
    var res = await http.get(Uri.parse("https://backend.deegolabs.com/mobile/deego/location"),
        headers:{
          "Authorization": "Bearer ${context.read<AuthStore>().accessToken}"
        });
    var beenList = jsonDecode(res.body);
    if(res.statusCode == 200){
      // print(beenList["deegoPage"]["items"]);

      setState(() {
        deegoList = beenList["deegoPage"]["items"];
      });
    }

  }

  getDeegoFavorite()async{
    var res = await http.get(Uri.parse("https://backend.deegolabs.com/mobile/deego/favorite"),
        headers: {"Authorization": "Bearer ${context.read<AuthStore>().accessToken}"}
    );
    var list = jsonDecode(res.body);

    if(res.statusCode == 200){
      setState(() {
        favoriteSerialNumbers = list["favoriteDeegoPage"]["items"];
        // print("${favoriteSerialNumbers}");
        // print("리스트 ${favoriteList}");
      });
    }else {
      // print("${list.body}");
    }
  }
  
  patchFavorite(String serieal)async{
    // print(serieal);
    var res = await http.patch(Uri.parse("https://backend.deegolabs.com/mobile/deego/favorite"),
        headers:{
      "Authorization": "Bearer ${context.read<AuthStore>().accessToken}"
    },
        body: {
          "deegoSerialNumber": serieal
        }
    );

    var favorite = jsonDecode(res.body);

        if(res.statusCode == 200){
          // print(favorite["isRemoved"]);
          // print("${res.body}");
          if(favorite["isRemoved"]) {
            showDialog(context: context, builder: (BuildContext context) {
              return CustomPopup(
                content: "즐겨찾기가 취소되었습니다.", confirmText: "확인", onConfirm: () {
                Navigator.pop(context);
                setState(() {
                  getDeegoFavorite();
                });
              }, onCancel: () => Navigator.pop(context),);
            });
          } else {
            showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPopup(
                content: "즐겨찾기가 완료되었습니다.",
                confirmText: "확인",
                onConfirm: () {
                  Navigator.pop(context);
                  setState(() {
                    getDeegoFavorite();
                  });
                },
                onCancel: () => Navigator.pop(context),
              );
            });
      }
    }
        else{
          // print("${res.body}");
          showDialog(context: context, builder: (BuildContext context){
            return CustomPopup(content: "문제가 발생하였습니다.", confirmText: "확인", onConfirm: () => Navigator.pop(context),onCancel: () => Navigator.pop(context),);
          });
        }
  }

  Widget isBrokenWidget(isBroken) {
    if (isBroken) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFF727272),
        ),
        // padding: EdgeInsets.all(1),
        child: Text(
          "사용불가능",
          style: TextStyle(
              color: Colors.white,
              fontSize: 12
          ),
        ),
      );
    } else {
      // answerDTO가 null이 아니면 "답변등록"을 표시하는 위젯을 반환
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



class Been extends StatefulWidget {
  const Been({super.key});

  @override
  State<Been> createState() => _BeenState();
}

class _BeenState extends State<Been> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
