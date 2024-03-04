import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'my_flutter_app_icons.dart';

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

        return;
      }

      setState(() {
        context.read<footerStore>().tab = index;

      });
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height/9.5,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation: 12,
        currentIndex: context.read<footerStore>().tab,
        backgroundColor: Colors.white,
        onTap: (i) {
          _onItemTapped(i);
          switch (i) {
            case 0:
              Navigator.pushReplacementNamed(context, "/");
              break;
            case 1:
              Navigator.pushReplacementNamed(context, "/map");
              // print("여기냐4");

              break;
            case 2:
              Navigator.pushReplacementNamed(context, "/point");
              // print("여기냐5");
              break;
            case 3:
              Navigator.pushReplacementNamed(context, "/setting");
              // print("여기냐6");
              break;
            case 4:
              Navigator.pushNamed(context, "/login");
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(MyFlutterApp.home_1,), label: '홈'),
          BottomNavigationBarItem(icon: Icon(MyFlutterApp.location), label: '디고찾기'),
          BottomNavigationBarItem(icon: Icon(MyFlutterApp.point), label: '포인트'),
          BottomNavigationBarItem(icon: Icon(MyFlutterApp.user), label: '설정'),
        ],
      ),
    );
  }
}
