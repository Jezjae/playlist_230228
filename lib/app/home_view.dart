

import 'package:flutter/material.dart';
import 'package:the_last_playlist/app/LikePlaylist.dart';
import 'package:the_last_playlist/app/MyPlaylist.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  //페이지 이동하기 위한 리스트에 위젯으로 페이지 넣어주기
  static List<Widget> pages = <Widget>[
    Navigator(
      onGenerateRoute: (routeSettings){
        return MaterialPageRoute(builder: (context) => const MyPlaylist());
      },
    ),
    LikePlaylist(),
  ];

  //페이지 선택 리스트 인덱스
  int _selecIndex = 0;

  //누르면 셋스테이지 해서 페이지 창 바꾸기
  void _onTap(int index) {
    setState(() {
      _selecIndex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[_selecIndex],

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selecIndex,
          onTap: _onTap,
          selectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.queue_music, color: Colors.black87,), label: '플레이리스트'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite, color: Colors.black87,), label: '관심목록'),
          ]
      ),
    );
  }
}
