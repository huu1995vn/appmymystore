import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/lifecyclewatcherstate.dart';
import 'package:mymystore/core/components/mm_barcode_scanner.dart';
import 'package:mymystore/core/popular.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/firebase/cloud_firestore.service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/utilities/size_config.dart';
import 'package:mymystore/pages/home/widgets/sale.widget.dart';
import 'package:mymystore/pages/profile/profile.page.dart';
import 'package:provider/provider.dart';

import 'widgets/category.widget.dart';
import 'widgets/report.widget.dart';

class HomePage extends StatefulWidget {
  final String? title;

  static String route() => '/home';

  const HomePage({super.key, this.title = "Trang chủ"});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends LifecycleWatcherState<HomePage>
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
  //https://github.com/mohesu/barcode_scanner/blob/master/lib/src/ai_barcode_scanner.dart
  Future barCodeScanner() async {
    var res = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MMBarcodeScanner(
          canPop: false,
          onScan: (String value) async {
            await CommonMethods.showDialogInfo(context, value);
          },
        ),
      ),
    );
    if (res != null) {
      CommonMethods.showToast(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    const padding = EdgeInsets.fromLTRB(CommonConstants.kDefaultPadding,
        CommonConstants.kDefaultPadding, CommonConstants.kDefaultPadding, 0);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: ListTile(
          leading:
              appProvider.user.avatar(size: CommonConstants.kSizeAvatarSmall),
          title: Text(
            appProvider.user.name,
            style: const TextStyle(color: AppColors.white),
          ),
          subtitle: Text("info.store".tr,
              style: const TextStyle(color: AppColors.white50)),
          onTap: () => Navigator.pushNamed(context, ProfilePage.route()),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              AppIcons.settings_overscan,
              color: AppColors.white,
            ),
            onPressed: () => {barCodeScanner()},
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
        const SaleWidget(),
        const CategoryWidget(),
        ReportWidget(),
      ],
    );
  }
}
