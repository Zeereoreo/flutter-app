import 'package:deego_client/home.dart';
import 'package:deego_client/main.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 20,
      margin: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // 현재 페이지가 Home 페이지인 경우에만 동작하도록 설정
              if (!(ModalRoute.of(context)?.settings.name == Home.routeName)) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MyApp()),
                      (route) => false,
                );
              }
            },
            child: const Image(image: AssetImage('assets/images/deego_logo.png')),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
            },
            child: Icon(Icons.notifications_none, size: 40),
          ),
        ],
      ),
    );
  }
}
