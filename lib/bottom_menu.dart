import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: (i) {
        _onItemTapped(i);
        print(_selectedIndex);
          switch(i){
            case 0:
              Navigator.pushNamed(context, "/");
              break;
            case 1:
              Navigator.pushNamed(context, "/map");
              break;
            case 2:
              Navigator.pushNamed(context, "/point");
              break;
            case 3:
              Navigator.pushNamed(context, "/setting");
              break;
            case 4:
              Navigator.pushNamed(context, "/login");
              break;
          }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: '디고찾기'),
        BottomNavigationBarItem(icon: Icon(Icons.store_rounded), label: '포인트'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
      ],
    );
  }
}
