// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/firebase/firebase_messaging_service.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'main/index.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key, this.indexTab});
  final int? indexTab;
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late int _totalNotifications;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  @override
  void initState() {
    _totalNotifications = 0;
    Timer(
        Duration(seconds: 0),
        () => {
              if (widget.indexTab != null && _selectedIndex != widget.indexTab)
                {onPressedTab(widget.indexTab ?? 0)}
            });

    initApp();

    super.initState();
  }

  initApp() {
    FirebaseMessagingService.streamMessage.stream.listen((notification) {
      if (notification != null) {
        setState(() {
          _totalNotifications++;
        });
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(notification.title ?? "",
                          style: const TextStyle().bold),
                      Text(notification.body ?? "")
                    ],
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                        child: Text(
                          'close'.tr(),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        onPressed: () {
                          CommonNavigates.pop(context, false);
                        })
                  ],
                ));
      }
    });
  }

  onPressedTab(int index) {
    if (!APITokenService.isValid && index == 3) {
      CommonNavigates.toLoginPage(context, isReplace: false);
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
    if (_pageController.hasClients) _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    CommonMethods.versionCheck(context);
    Size size = MediaQuery.of(context).size;
    SizeConfig.init(size);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          NewsPage(),
          NotifycationPage(),
          DashboardPage(),
        ],
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => {onPressedTab(value)},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (CommonMethods.isLogin) {
            CommonNavigates.toMyProductPage(context, item: ProductModel());
          } else {
            CommonMethods.showToast("Vui lòng đăng nhập trước");
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RxButtonBar(
                icon: const Icon(AppIcons.home_1, size: 17),
                isEnable: _selectedIndex == 0,
                onPressed: () {
                  onPressedTab(0);
                },
              ),
              RxButtonBar(
                icon: Icon(AppIcons.earth, size: 17),
                isEnable: _selectedIndex == 1,
                onPressed: () {
                  onPressedTab(1);
                },
              ),
              const SizedBox(
                width: 40,
              ),
              Stack(children: <Widget>[
                RxButtonBar(
                  icon: Icon(AppIcons.alarm, size: 19),
                  isEnable: _selectedIndex == 2,
                  onPressed: () {
                    onPressedTab(2);
                  },
                ),
                if (_totalNotifications > 0)
                  Positioned(
                    right: 6,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$_totalNotifications',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ]),
              RxButtonBar(
                icon: const Icon(AppIcons.user_1, size: 17),
                isEnable: _selectedIndex == 3,
                onPressed: () {
                  onPressedTab(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
