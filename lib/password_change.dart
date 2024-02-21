// import 'package:deego_client/header.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class UserInfo extends StatefulWidget {
//   const UserInfo({super.key});
//
//   @override
//   State<UserInfo> createState() => _UserInfoState();
// }
//
// class _UserInfoState extends State<UserInfo> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           image: AssetImage('assets/images/bgimage.png'), // 배경 이미지
//         ),
//       ),
//       child: Scaffold(
//         body: Container(
//           margin: EdgeInsets.all(10),
//           child: Column(
//             children: [
//               const Header(),
//               Container(
//                 child: Column(
//                   children: [
//
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget infoName(String name){
//     return Container(
//       child: Text(
//         name,
//         style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.white
//         ),
//       ),
//     );
//   }
//
//   Widget userInput(){
//     return Container(
//       child: TextField(
//
//       ),
//     );
//   }
// }
