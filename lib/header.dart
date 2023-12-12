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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
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
