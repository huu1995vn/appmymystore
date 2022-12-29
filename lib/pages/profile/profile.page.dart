import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/services/info_device.service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/pages/profile/header.dart';

typedef ProfileOptionTap = void Function();

class ProfileOption {
  String title;
  Widget icon;
  Color? titleColor;
  ProfileOptionTap? onClick;
  Widget? trailing;

  ProfileOption({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor,
    this.trailing,
  });

  ProfileOption.arrow({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor = const Color(0xFF212121),
    this.trailing = const Icon(Icons.chevron_right, size: 24),
  });
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static String route() => '/profile';

  @override
  State<ProfilePage> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  get widgetOptions => <Widget>[
        MMBorder(
          child: MMListTile(
            title: const MMText(data: "Edit Profile"),
            leading: Container(
              width: 25,
              alignment: Alignment.center,
              child: const Icon(AppIcons.user_1),
            ),
            onTap: () {},
            trailing: const Icon(
              AppIcons.keyboard_arrow_right,
            ),
          ),
        ),
        MMBorder(
          child: MMListTile(
            title: MMText(data: "setting".tr),
            leading: Container(
              width: 25,
              alignment: Alignment.center,
              child: const Icon(AppIcons.cog_1),
            ),
            onTap: () {},
            trailing: const Icon(
              AppIcons.keyboard_arrow_right,
            ),
          ),
        ),
        MMBorder(
          child: MMListTile(
            title: MMText(data: "Help Center"),
            leading: Container(
              width: 25,
              alignment: Alignment.center,
              child: const Icon(AppIcons.help_1),
            ),
            onTap: () {},
            trailing: const Icon(
              AppIcons.keyboard_arrow_right,
            ),
          ),
        ),
        MMBorder(
          child: MMListTile(
            title: MMText(data: "logout".tr),
            leading: Container(
              width: 25,
              alignment: Alignment.center,
              child: const Icon(AppIcons.exit),
            ),
            onTap: () => {AuthService.logout(context)},
            trailing: const Icon(
              AppIcons.keyboard_arrow_right,
            ),
          ),
        ),
       
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.primary, //change your color here
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: CustomScrollView(
          slivers: [
            const SliverList(
              delegate: SliverChildListDelegate.fixed([
                Padding(
                  padding: EdgeInsets.all(CommonConstants.kDefaultPadding),
                  child: ProfileHeader(),
                ),
              ]),
            ),
            _buildBody(),
          ],
        ),
        bottomSheet: Container(
            color: Colors.transparent,
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
                    InfoDeviceService.infoDevice.DeviceVersion ?? "1.1.0"))));
  }

  Widget _buildBody() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: CommonConstants.kDefaultPadding),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return widgetOptions[index];
          },
          childCount: widgetOptions.length,
        ),
      ),
    );
  }

  
}
