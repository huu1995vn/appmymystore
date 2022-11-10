import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/components/part.dart';
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String route() => '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static _profileIcon(String last) => 'assets/icons/profile/$last';

  bool _isDark = false;

  get datas => <ProfileOption>[
        ProfileOption.arrow(title: 'Edit Profile', icon: const Icon(AppIcons.user_1)),
        ProfileOption.arrow(title: 'Setting', icon: const Icon(AppIcons.cog_1)),
        ProfileOption.arrow(title: 'Help Center', icon: const Icon(AppIcons.help_1)),
        ProfileOption(
          title: 'Logout',
          icon: const Icon(AppIcons.exit),
          titleColor: const Color(0xFFF75555),
        ),
      ];

  _languageOption() => ProfileOption(
      title: 'Language',
      icon: _profileIcon('more_circle@2x.png'),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'English (US)',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF212121)),
            ),
            const SizedBox(width: 16),
            Image.asset('assets/icons/profile/arrow_right@2x.png', scale: 2)
          ],
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.primary, //change your color here
          ),
          leading: RxGoBack(context),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          // title: Text(
          //   'personalinformation'.tr,
          //   style: TextStyle(color: AppColors.primary),
          // ),
          elevation: 0.0,
        ),
        body: CustomScrollView(
          slivers: [
            const SliverList(
              delegate: SliverChildListDelegate.fixed([
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ProfileHeader(),
                ),
              ]),
            ),
            _buildBody(),

            // Center(
            //         child: Text(
            //             InfoDeviceService.infoDevice.DeviceVersion ?? "1.1.0"))
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
      padding: const EdgeInsets.only(top: 10.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final data = datas[index];
            return _buildOption(context, index, data);
          },
          childCount: datas.length,
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, int index, ProfileOption data) {
    return ListTile(
      leading: data.icon,
      title: Text(
        data.title,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: data.titleColor),
      ),
      trailing: data.trailing,
      onTap: () {},
    );
  }
}
