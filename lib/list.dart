import 'package:flutter/material.dart';


class List extends StatefulWidget {
  const List({super.key});

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
