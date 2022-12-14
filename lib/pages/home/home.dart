import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/lifecyclewatcherstate.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/popular.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/firebase/cloud_firestore.service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/utilities/size_config.dart';
import 'package:mymystore/pages/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String? title;

  static String route() => '/home';

  const HomeScreen({super.key, this.title = "Trang chủ"});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends LifecycleWatcherState<HomeScreen>
    with TickerProviderStateMixin {
  late final datas = homePopularProducts;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    CloudFirestoreSerivce.subcriptuser(context);
    CloudFirestoreSerivce.setdevice(isOnline: true);
    animationController.reverse();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Provider.of<AppProvider>(context, listen: false)
            .setUserModel(APITokenService.user);
      }
    });
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

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    const padding = EdgeInsets.fromLTRB(
        CommonConstants.kDefaultPadding, CommonConstants.kDefaultPadding, CommonConstants.kDefaultPadding, 0);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: ListTile(
          leading: appProvider.user.avatar(size: CommonConstants.kSizeAvatarSmall),
          title: Text(
            appProvider.user.name,
            style: const TextStyle(color: AppColors.white),
          ),
          subtitle: Text("info.store".tr,
              style: const TextStyle(color: AppColors.white50)),
          onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              AppIcons.frame_expand,
              color: AppColors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(AppIcons.cog_1, color: AppColors.white),
            onPressed: () {
              CommonNavigates.toSettingsPage(context);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) => _buildBody(context)),
                childCount: 1,
              ),
            ),
          ),
         
          // const SliverAppBar(flexibleSpace: SizedBox(height: 24))
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Text("Nội dung")
        // const MostPupularCategory(),
      ],
    );
  }

}
