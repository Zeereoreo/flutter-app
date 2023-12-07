import 'package:flutter/material.dart';



class Header extends StatelessWidget {
  const Header({super.key});
  @override
  Widget build(BuildContext context) {
  return  Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
    width: double.infinity,
    height: MediaQuery.of(context).size.height/20,
    margin: EdgeInsets.only(top: 40),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(image: AssetImage('assets/images/deego_logo.png') ),
        Icon(Icons.notifications_none,size: 40,),
      ],
    ),
  );
  }

}