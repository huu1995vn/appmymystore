// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget RxDivider({double indent = 20}) {
  return Divider(
      thickness: 1, // thickness of the line
      indent: indent,
      endIndent: indent,
      height: 1);
}

Widget RxBuildItem(
    {required String title,
    Widget? icon,
    void Function()? onTap,
    Widget? trailing}) {
  return ListTile(
    leading: icon,
    title: Text(title),
    trailing: trailing,
    onTap: onTap,
  );
}

Widget RxText(String data,
    {Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines}) {
  return Text(data ?? "not.update".tr(),
      style: style, textAlign: textAlign, maxLines: maxLines);
}

class RxDisabled extends StatelessWidget {
  final Widget child;
  final bool disabled;

  const RxDisabled({Key? key, this.disabled = false, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
        absorbing: disabled,
        child: AnimatedOpacity(
            opacity: disabled ? 0.5 : 1,
            duration: const Duration(milliseconds: 500),
            child: child));
  }
}

class RxWebView extends StatefulWidget {
  String? url;
  String? title;
  String? javaScriptString;
  RxWebView({super.key, this.url, this.title, this.javaScriptString});
  @override
  RxWebViewState createState() => RxWebViewState();
}

class RxWebViewState extends State<RxWebView> {
  final _key = UniqueKey();
  bool isLoading = true;
  WebViewController? _webViewController;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? ""),
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: (progress) {
                if (progress > 20) {
                  if (_webViewController != null &&
                      widget.javaScriptString != null) {
                    _webViewController!.runJavascript(widget.javaScriptString!);
                  }
                  if (isLoading) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
              },
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
              },
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ));
  }
}

class RxCustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

Widget RxListSkeleton({int barCount = 3}) {
  try {
    return ListSkeleton(
      style: SkeletonStyle(
        // backgroundColor: SystemVariables.themeData.cardColor,
        isShowAvatar: false,
        barCount: barCount,
        isAnimation: true,
      ),
    );
  } catch (e) {}
  return const Center(child: CupertinoActivityIndicator());
}

Widget RxCardSkeleton(
    {int barCount = 3,
    bool isShowAvatar = true,
    bool isCircleAvatar = false,
    bool isBorderRadius = true}) {
  try {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: CardSkeleton(
          style: SkeletonStyle(
            // backgroundColor: SystemVariables.themeData.cardColor,
            // theme: SystemVariables.themeData.primaryColor == Colors.black
            //     ? SkeletonTheme.Dark
            //     : SkeletonTheme.Light,
            isShowAvatar: isShowAvatar ?? true,
            isCircleAvatar: isCircleAvatar ?? false,
            borderRadius:
                BorderRadius.all(Radius.circular(isBorderRadius ? 20.0 : 0)),
            padding: EdgeInsets.all(isBorderRadius ? 20.0 : 10.0),
            barCount: barCount,
            isAnimation: true,
          ),
        ));
  } catch (e) {}
  return const Center(child: CupertinoActivityIndicator());
}

Widget RxCardListSkeleton(
    {int barCount = 3, bool isShowAvatar = true, bool isCircleAvatar = false}) {
  return CardListSkeleton(
    style: SkeletonStyle(
      // backgroundColor: SystemVariables.themeData.cardColor,
      isShowAvatar: isShowAvatar ?? true,
      isCircleAvatar: isCircleAvatar ?? false,
      barCount: barCount,
    ),
  );
}

Widget RxNoFound({required String urlImage, String? message}) {
  return SizedBox(
    height: SizeConfig.screenHeight -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        25,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RxImage(
          urlImage,
          fullHeight: false,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          message ?? "notfound".tr(),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget RxLoginAccountLabel(context) {
  return InkWell(
    onTap: () {
      CommonNavigates.toLoginPage(context);
    },
    child: Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'message.str041'.tr(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          Text(
            "login".tr(),
            style: const TextStyle(
                color: AppColors.primary500,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

Widget RxCreateAccountLabel(context) {
  return InkWell(
    onTap: () {
      CommonNavigates.toRegisterPage(context);
    },
    child: Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "message.str036".tr(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          Text(
            "registnow".tr(),
            style: const TextStyle(
                color: AppColors.primary500,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

class RxAvatarImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  const RxAvatarImage(this.url, {Key? key, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: RxCircleAvatar(
            backgroundImage: RxImageProvider(url)));
  }
}

class RxCircleAvatar extends CircleAvatar {
  const RxCircleAvatar(
      {super.key,
      Widget? child,
      Color? backgroundColor,
      ImageProvider<Object>? backgroundImage,
      ImageProvider<Object>? foregroundImage,
      // void Function(Object, StackTrace)? onBackgroundImageError,
      void Function(Object, StackTrace)? onForegroundImageError,
      Color? foregroundColor,
      double? radius,
      double? minRadius,
      double? maxRadius})
      : super(
            child: child,
            backgroundColor: backgroundColor ?? Colors.transparent,
            backgroundImage: backgroundImage,
            foregroundImage: foregroundImage,
            // onBackgroundImageError: onBackgroundImageError,
            foregroundColor: foregroundColor,
            radius: radius,
            minRadius: minRadius,
            maxRadius: maxRadius);
}
ImageProvider<Object> RxImageProvider(String url) {
    if (url.isEmpty) {
      url = NOIMAGE;
    }
    if (CommonMethods.isURl(url)) {
      if (CommonConfig.haveCacheImage) {
        return CachedNetworkImageProvider(url);
      } else {
        return NetworkImage(url);
      }
    } else {
      if (url.contains("assets/")) {
        return AssetImage(url);
      }
      return FileImage(File(url));
    }
  }

class RxSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  RxSliverPersistentHeaderDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(RxSliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class RxSliverAppBarTabDelegate extends SliverPersistentHeaderDelegate {
  PreferredSize? child;

  RxSliverAppBarTabDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => child!.preferredSize.height;

  @override
  double get minExtent => child!.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
