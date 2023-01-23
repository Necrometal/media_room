import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/pages/media_player.dart';
import 'package:media_room/src/pages/media_playlist.dart';
import 'package:media_room/src/pages/member_list.dart';

class MediaNavigationBar extends StatefulWidget {
  const MediaNavigationBar({Key? key}) : super(key: key);

  @override
  State<MediaNavigationBar> createState() => _MediaNavigationBarState();
}

class _MediaNavigationBarState extends State<MediaNavigationBar> {

  int _selectedIndex = 0;
  PageController? _pageController;

  static const List<Widget> _widgetOptions = <Widget>[
    MediaPlayerPage(),
    MediaPlaylistPage(),
    MemberList()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController?.animateToPage(
        index,
        duration: const Duration(milliseconds: 500), 
        curve: Curves.easeOut
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 10,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Icon(CupertinoIcons.double_music_note)
              ),
              label: '',
              
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Icon(CupertinoIcons.list_bullet)
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Icon(CupertinoIcons.person_2)
              ),
              label: '',
            ),
          ],
          selectedItemColor: cyan,
          unselectedItemColor: grey,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
