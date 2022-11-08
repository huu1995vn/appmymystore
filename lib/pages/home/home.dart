import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/lifecyclewatcherstate.dart';
import 'package:mymystore/core/components/product_card.dart';
import 'package:mymystore/core/popular.dart';
import 'package:mymystore/core/services/firebase/cloud_firestore.service.dart';
import 'package:mymystore/core/utilities/constants.dart';
import 'package:mymystore/pages/detail/detail_screen.dart';
import 'package:mymystore/pages/home/most_popular.dart';
import 'package:mymystore/pages/home/special_offer.dart';
import 'package:mymystore/pages/mostpopular/most_popular_screen.dart';
import 'package:mymystore/pages/profile/profile_screen.dart';
import 'package:mymystore/pages/special_offers/special_offers_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? title;

  static String route() => '/home';

  const HomeScreen({super.key, this.title = "Trang chủ"});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends LifecycleWatcherState<HomeScreen> {
  late final datas = homePopularProducts;
  @override
  void initState() {
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
  @override
  Widget build(BuildContext context) {
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
          leading: const CircleAvatar(
            backgroundImage: AssetImage('$kIconPath/me.png'),
            radius: 24,
          ),
          title: const Text("Trần Thị Ngọc Mỹ"),
          subtitle: const Text('Thông tin cửa hàng'),
          onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
        ),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.frame_expand),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(AppIcons.settings),
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
          const SliverAppBar(flexibleSpace: SizedBox(height: 24))
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SpecialOffers(onTapSeeAll: () => _onTapSpecialOffersSeeAll(context)),
        const SizedBox(height: 24),
        MostPopularTitle(onTapseeAll: () => _onTapMostPopularSeeAll(context)),
        const SizedBox(height: 24),
        const MostPupularCategory(),
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
