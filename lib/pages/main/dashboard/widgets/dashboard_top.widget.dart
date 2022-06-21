import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/providers/user_provider.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class DashboardTopWidget extends StatefulWidget {
  const DashboardTopWidget({Key? key}) : super(key: key);

  @override
  DashboardTopWidgetState createState() => DashboardTopWidgetState();
}

class DashboardTopWidgetState extends State<DashboardTopWidget> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return ListTile(
      leading: RxAvatarImage(userProvider.urlImage, width: 50),
      title: InkWell(
          onTap: () {
            CommonNavigates.toUserPage(context);
          },
          child: Text(
            userProvider.fullname.toUpperCase(),
            style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppColors.white),
          )),
      trailing: InkWell(
          onTap: () {
            CommonNavigates.toSettingsPage(context);
          },
          child: const Icon(
            Icons.settings,
            color: AppColors.white,
          )),
      onTap: () => {},
    );
  }
}
