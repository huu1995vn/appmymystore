// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';
import 'package:get/get.dart';
import 'package:mymystore/core/components/lifecyclewatcherstate.dart';
import 'package:provider/provider.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:flutter/material.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/firebase/cloud_firestore.service.dart';
import 'package:mymystore/core/services/firebase/firebase_messaging_service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/utilities/size_config.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends LifecycleWatcherState<MyPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
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
    // FirebaseInAppMessagingService.triggerEvent("main_screen_opened");
  }

  StreamSubscription<PushNotification>? submess;
  initApp() async {}
  onPressedTab(int index) {
    setState(() {});
    if (_pageController.hasClients) _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    submess!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CommonMethods.versionCheck(context);
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          if (CommonMethods.isLogin) {
            // CommonNavigates.toMyProductPage(context, item: ProductModel());
          } else {
            CommonMethods.showToast("please.login".tr);
            CommonNavigates.toLoginPage(context);
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
