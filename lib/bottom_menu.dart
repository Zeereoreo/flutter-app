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
        print("${context.read<footerStore>().tab}이랑 ${index}");
        return ;
      }

      setState(() {
        context.read<footerStore>().tab = index;
        print("여기냐2");
      });
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: context.read<footerStore>().tab,

      onTap: (i) {
        _onItemTapped(i);
        switch (i) {
          case 0:
            Navigator.pushReplacementNamed(context, "/");
            break;
          case 1:
            Navigator.pushReplacementNamed(context, "/map");
            print("여기냐4");

            break;
          case 2:
            Navigator.pushReplacementNamed(context, "/point");
            print("여기냐5");
            break;
          case 3:
            Navigator.pushReplacementNamed(context, "/setting");
            print("여기냐6");
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
