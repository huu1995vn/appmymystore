import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/lifecyclewatcherstate.dart';
import 'package:mymystore/core/components/part.dart';
import 'package:mymystore/core/components/product_card.dart';
import 'package:mymystore/core/popular.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/firebase/cloud_firestore.service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/utilities/constants.dart';
import 'package:mymystore/core/utilities/size_config.dart';
import 'package:mymystore/pages/detail/detail_screen.dart';
import 'package:mymystore/pages/home/report_view.dart';
import 'package:mymystore/pages/home/most_popular.dart';
import 'package:mymystore/pages/home/special_offer.dart';
import 'package:mymystore/pages/mostpopular/most_popular_screen.dart';
import 'package:mymystore/pages/profile/profile_screen.dart';
import 'package:mymystore/pages/special_offers/special_offers_screen.dart';
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
    final appProvider = Provider.of<AppProvider>(context);

    const padding = EdgeInsets.fromLTRB(
        kDefaultPadding, kDefaultPadding, kDefaultPadding, 0);
    return Scaffold(
      // appBar: AppBar(
      //     centerTitle: true,
      //     title: HomeAppBar(),
      //     elevation: 0.0,
      //     // actions: [widget.action ?? Container()],
      //   ),
      appBar: AppBar(
        elevation: 0.0,
        title: ListTile(
          leading: MMAvatarImage(
            appProvider.user.mmimage,
            size: 39,
          ),
          title: Text(
            appProvider.user.name!,
            style: TextStyle(color: AppColors.white),
          ),
          subtitle: const Text('Thông tin cửa hàng',
              style: TextStyle(color: AppColors.white50)),
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
          SliverPadding(
            padding: padding,
            sliver: _buildPopulars(),
          ),
          // const SliverAppBar(flexibleSpace: SizedBox(height: 24))
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SpecialOffers(onTapSeeAll: () => _onTapSpecialOffersSeeAll(context)),
        const ReportView(),
        // const MostPupularCategory(),
      ],
    );
  }

  Widget _buildPopulars() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 185,
        mainAxisSpacing: 24,
        crossAxisSpacing: 16,
        mainAxisExtent: 285,
      ),
      delegate: SliverChildBuilderDelegate(_buildPopularItem, childCount: 30),
    );
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    final data = datas[index % datas.length];
    return ProductCard(
      data: data,
      ontap: (data) => Navigator.pushNamed(context, ShopDetailScreen.route()),
    );
  }

  void _onTapMostPopularSeeAll(BuildContext context) {
    Navigator.pushNamed(context, MostPopularScreen.route());
  }

  void _onTapSpecialOffersSeeAll(BuildContext context) {
    Navigator.pushNamed(context, SpecialOfferScreen.route());
  }
}
