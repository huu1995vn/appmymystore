// ignore_for_file: prefer_const_constructors

import 'package:raoxe/core/components/index.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:raoxe/pages/dashboard/dashboard_page.dart';
import 'package:raoxe/pages/home/home_page.dart';
import 'package:raoxe/pages/login/login_page.dart';
import 'package:raoxe/pages/news/news_page.dart';
import 'package:raoxe/pages/notifycation/notifycation_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  onPressedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig.init(size);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          NewsPage(),
          NotifycationPage(),
          DashboardPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RxButtonBar(
              icon: const Icon(Icons.home),
              isEnable: _selectedIndex == 0,
              onPressed: () {
                onPressedTab(0);
              },
            ),
            RxButtonBar(
              icon: const Icon(Icons.newspaper),
              isEnable: _selectedIndex == 1,
              onPressed: () {
                onPressedTab(1);
              },
            ),
            const SizedBox(
              width: 40,
            ),
            RxButtonBar(
              icon: const Icon(Icons.notifications),
              isEnable: _selectedIndex == 2,
              onPressed: () {
                onPressedTab(2);
              },
            ),
            RxButtonBar(
              icon: const Icon(Icons.person),
              isEnable: _selectedIndex == 3,
              onPressed: () {
                if (true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else {
                  onPressedTab(3);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
