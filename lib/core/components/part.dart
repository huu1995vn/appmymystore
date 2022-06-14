// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:raoxe/core/components/index.dart';
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
  String url;
  String? title;

  RxWebView({super.key, required this.url, this.title});
  @override
  RxWebViewState createState() => RxWebViewState();
}

class RxWebViewState extends State<RxWebView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
        appBar: AppBar(
          title: Text(widget.title ?? ""),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
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
