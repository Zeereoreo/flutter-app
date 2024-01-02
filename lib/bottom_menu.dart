import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      if(context.read<footerStore>().tab == index){
        return null;
      }

      setState(() {
        context.read<footerStore>().tab = index;
      });
    }

    return BottomNavigationBar(
      showUnselectedLabels: true,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: context.read<footerStore>().tab,

      onTap: (i) {
        _onItemTapped(i);
        print(i);
        switch (i) {
          case 0:
            Navigator.pushReplacementNamed(context, "/");
            break;
          case 1:
            Navigator.pushReplacementNamed(context, "/map");
            break;
          case 2:
            Navigator.pushReplacementNamed(context, "/point");
            break;
          case 3:
            Navigator.pushReplacementNamed(context, "/setting");
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
