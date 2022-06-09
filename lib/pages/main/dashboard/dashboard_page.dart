// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/rx_card.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // CommonMethods.lockScreen();
  }
  @override
  Widget build(BuildContext context ) {
    return RxScaffold(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(CommonMethods.buildUrlHinhDaiDien(
                  APITokenService.fileId,
                  rewriteUrl: APITokenService.fullname)),
              backgroundColor: Colors.transparent,
            ),
            title:
                Text(APITokenService.fullname, style: const TextStyle(color: AppColors.white).bold),
            subtitle: Text("message.str032".tr(),
                style: TextStyle(color: AppColors.info).italic.underline),
            trailing: GestureDetector(
                onTap: () => CommonNavigates.toSettingsPage(context),
                child: SizedBox(
                  child: Icon(Icons.settings, color: AppColors.white),
                )),
            onTap: () {
              CommonNavigates.toUserPage(context);
            },
          ),
      ),
      Expanded(
          child:
              RxWrapper(body: RxCard(child: Column(children: <Widget>[])))),
    ]));
  }
}
