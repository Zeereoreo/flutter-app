import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

void main() async {
  runApp(const NaverMapApp());
}



class NaverMapApp extends StatelessWidget {
  const NaverMapApp({Key? key});



  @override
  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();

    return MaterialApp(
      home: Scaffold(
        body: NaverMap(
          options: const NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
                target: NLatLng(37.568963, 126.646476),
                zoom: 10,
                bearing: 0,
                tilt: 0
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
            maxZoom: 16, // default is 21
            extent: NLatLngBounds(          // 한반도 내로 제한
              southWest: NLatLng(31.43, 122.37),
              northEast: NLatLng(44.35, 132.0),
            ),
          ),
          onMapReady: (controller) async {
            // final marker1 = NMarker(id: '1', position: (37.568963,126.646476));
            mapControllerCompleter.complete(controller);  // Completer에 지도 컨트롤러 완료 신호 전송
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
    );
  }
}