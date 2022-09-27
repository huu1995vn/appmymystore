// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/lifecyclewatcherstate.dart';
import 'package:raoxe/core/providers/notification_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/firebase/cloud_firestore.service.dart';
import 'package:raoxe/core/services/firebase/dynamic_link.service.dart';
import 'package:raoxe/core/services/firebase/firebase_in_app_messaging_service.dart';
import 'package:raoxe/core/services/firebase/firebase_messaging_service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'main/index.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key, this.indexTab});
  final int? indexTab;
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends LifecycleWatcherState<MyPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    Timer(
        Duration(seconds: 0),
        () => {
              if (widget.indexTab != null && _selectedIndex != widget.indexTab)
                {onPressedTab(widget.indexTab ?? 0)}
            });

    initApp();
    super.initState();
    CloudFirestoreSerivce.subcriptuser(context);
    CloudFirestoreSerivce.setdevice(isOnline: true);
  }

  @override
  void onDetached() {
    // CloudFirestoreSerivce.setdevice(isOnline: false);
  }

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    FirebaseInAppMessagingService.triggerEvent("main_screen_opened");
  }

  StreamSubscription<PushNotification>? submess;
  initApp() {
    Provider.of<NotificationProvider>(context, listen: false).getNotification();
    if (mounted) {
      submess =
          FirebaseMessagingService.streamMessage.stream.listen((message) async {
        if (message != null) {
          Provider.of<NotificationProvider>(context, listen: false)
              .getNotification();
          if (message.isBackgournd && message.data!["link"] != null) {
            String link = message.data!["link"].toString().toLowerCase();
            CommonMethods.launchURL(link);
            return;
          }
          if (message.data!["code"] != null &&
              message.data!["code"].toString().contains("anotherlogin")) {
            return;
          }

          if (message.isBackgournd && message.data != null) {
            onDetailNotification(message);
          } else {
            if (message != null) {
              showSimpleNotification(
                Text(message.title!, style: TextStyle(color: AppColors.black)),
                leading: RxAvatarImage(ICON, size: 40),
                subtitle: Text(message.body!,
                    style: TextStyle(color: AppColors.black50)),
                background: AppColors.white,
                duration: Duration(seconds: 3),
                trailing: GestureDetector(
                    onTap: () {
                      onDetailNotification(message);
                    },
                    child: Text("detail".tr(),
                        style: TextStyle(color: AppColors.info))),
              );
            }
          }
        }
      });
      FirebaseInAppMessagingService.fiam.triggerEvent("on_foreground");
      DynamicLinkService.dynamicLinks.onLink.listen((dynamicLinkData) {
        // Navigator.pushNamed(context, dynamicLinkData.link.path);
        CommonMethods.showToast(dynamicLinkData.link.path);
      }).onError((error) {
        CommonMethods.wirtePrint('onLink error');
      });
    }
  }

  onDetailNotification(message) {
    String action = message.data!["action"].toString().toLowerCase();
    int? id = message.data!["id"] != null
        ? CommonMethods.convertToInt32(
            message.data!["id"] ?? message.data!["Id"])
        : null;
    switch (action) {
      case "product":
        CommonNavigates.toProductPage(context, id: id);
        break;
      case "my-product":
        CommonNavigates.toMyProductPage(context, id: id);
        break;
      case "news":
        CommonNavigates.toNewsPage(context, id: id);
        break;
      default:
        CommonNavigates.toNotificationPage(context, id: id);
        break;
    }
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
  void dispose() {
    submess!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: true);

    CommonMethods.versionCheck(context);
    Size size = MediaQuery.of(context).size;
    SizeConfig.init(size);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => {onPressedTab(value)},
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          HomePage(),
          NewsPage(),
          NotificationPage(),
          DashboardPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        onPressed: () {
          if (CommonMethods.isLogin) {
            CommonNavigates.toMyProductPage(context, item: ProductModel());
          } else {
            CommonMethods.showToast("please.login".tr());
          }
        },
        shape: RoundedRectangleBorder(
            // side: BorderSide(width: 1, color: Theme.of(context).cardColor),
            borderRadius: BorderRadius.circular(100)),
        child: Icon(
          Icons.add,
          color: AppColors.primary,
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
                if (notificationProvider.numNotification > 0)
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
                        '${notificationProvider.numNotification}',
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
