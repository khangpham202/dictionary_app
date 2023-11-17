import 'package:training/modules/search/view/search_screen.dart';
import 'package:training/modules/profile/view/profile_screen.dart';
import 'package:training/modules/translatePage/view/translate_screen.dart';
import 'package:flutter/material.dart';

class NavigationBottomBar extends StatefulWidget {
  final int indexScreen;
  const NavigationBottomBar({
    Key? key,
    this.indexScreen = 0,
  }) : super(key: key);

  @override
  State<NavigationBottomBar> createState() => NavigationBottomBarState();
}

class NavigationBottomBarState extends State<NavigationBottomBar> {
  late int _currentIndex;
  late final PageController _pageController =
      PageController(initialPage: widget.indexScreen);

  @override
  void initState() {
    _currentIndex = widget.indexScreen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomeScreen(),
          TranslateScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: 'Translate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
