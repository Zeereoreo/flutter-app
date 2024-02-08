import 'dart:async';
import 'dart:developer';
import 'package:deego_client/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

import 'bottom_menu.dart';


class NaverMapApp extends StatefulWidget {
  const NaverMapApp({Key? key}) : super(key: key);

  @override
  State<NaverMapApp> createState() => _NaverMapAppState();
}

class _NaverMapAppState extends State<NaverMapApp> {
  double? initialLat;
  double? initialLng;


  @override
  void initState() {
    super.initState();
    getInitialLocation();
  }

  void getInitialLocation() async {

    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
    setState(() {
      initialLat = location.latitude;
      initialLng = location.longitude;
    });

    print(initialLat);
    print(initialLng);
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
                  log("onMapReady", name: "onMapReady");
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
               child: Column(
                 children: [
                   Text("검색"),
                   Text("data"),
                   Text("data"),
                   Text("data"),


                 ],
               ),
             )
             ]
           ),

          bottomNavigationBar: const BottomMenu(),
      ),
       );
  }
}
