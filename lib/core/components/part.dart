// ignore_for_file: non_constant_identifier_names, must_be_immutable, import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/delegates/rx_select.delegate.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RxDivider extends Divider {
  const RxDivider({super.key, double indent = 20})
      : super(indent: indent, endIndent: indent, height: 1, thickness: 1);
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
          title: Text(widget.title ?? "", style: kTextHeaderStyle),
          centerTitle: true,
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
        backgroundColor:
            CommonConfig.isDark ? AppColors.blackLight : AppColors.white,
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
    return CardSkeleton(
      style: SkeletonStyle(
        backgroundColor:
            CommonConfig.isDark ? AppColors.blackLight : AppColors.white,
        isShowAvatar: isShowAvatar ?? true,
        isCircleAvatar: isCircleAvatar ?? false,
        borderRadius:
            BorderRadius.all(Radius.circular(isBorderRadius ? 20.0 : 0)),
        padding: EdgeInsets.all(isBorderRadius ? 20.0 : 10.0),
        barCount: barCount,
        isAnimation: true,
      ),
    );
  } catch (e) {}
  return const Center(child: CupertinoActivityIndicator());
}

Widget RxCardListSkeleton(
    {int barCount = 3, bool isShowAvatar = true, bool isCircleAvatar = false}) {
  return CardListSkeleton(
    style: SkeletonStyle(
      backgroundColor:
          CommonConfig.isDark ? AppColors.blackLight : AppColors.white,
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

class RxAvatarImage extends StatelessWidget {
  final String url;
  final double size;
  final BoxBorder? border;
  const RxAvatarImage(this.url, {Key? key, this.border, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        image: DecorationImage(
          image: RxImageProvider(url),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(size / 2)),
        border: border ??
            Border.all(
              color: AppColors.white,
              width: 3.0,
            ),
      ),
    );
    // SizedBox(
    //     width: width,
    //     height: height,
    //     child: RxCircleAvatar(
    //         backgroundImage: RxImageProvider(url)));
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

class RxRoundedButton extends StatelessWidget {
  const RxRoundedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color = AppColors.primary,
    this.radius,
  }) : super(key: key);

  final GestureTapCallback onPressed;
  final String title;
  final Color color;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 2.0, color: color!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? kDefaultPadding),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: color),
      ),
    );
  }
}

class RxPrimaryButton extends StatelessWidget {
  const RxPrimaryButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: kSizeHeight,
        decoration: kBoxDecorationStyle.copyWith(
            borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: kWhite,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

Widget rxTextInput(BuildContext context, String? value,
    {Widget? title,
    String? hintText = "Nhập",
    String? labelText,
    bool isBorder = false,
    TextInputType? keyboardType = TextInputType.text,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    void Function()? onTap}) {
  return ListTile(
    title: title ??
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: labelText ?? "",
                  style: kTextTitleStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyText1!.color)),
              if (validator != null)
                const TextSpan(
                    text: ' *',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ),
    subtitle: RxInput(value ?? "",
        readOnly: onTap != null,
        isBorder: isBorder,
        keyboardType: keyboardType,
        onChanged: onChanged,
        hintText: hintText,
        onTap: onTap,
        style: TextStyle(
                color: value != null && value.length > 0
                    ? AppColors.primary
                    : null)
            .size(13),
        validator: validator,
        suffixIcon: const Icon(null)),
  );
}

Widget rxSelectInput(BuildContext context, String type, dynamic id,
    {Widget? title,
    String? labelText,
    String? hintText,
    bool isBorder = false,
    bool Function(dynamic)? fnWhere,
    dynamic Function(dynamic)? afterChange,
    String? Function(String?)? validator}) {
  var name = CommonMethods.getNameMasterById(type, id);
  return ListTile(
    title: title ??
        RichText(
          text: TextSpan(
            // text: lableText ?? type.tr(),
            children: <TextSpan>[
              TextSpan(
                  text: labelText ?? type.tr(),
                  style: kTextTitleStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyText1!.color)),
              if (validator != null)
                const TextSpan(
                    text: ' *',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ),
    subtitle: RxInput(name,
        isBorder: isBorder,
        readOnly: true,
        hintText: hintText ?? "choose.text".tr(),
        style: TextStyle(
                color:
                    name != null && name.length > 0 ? AppColors.primary : null)
            .size(13),
        validator: validator, onTap: () {
      _onSelect(context, type, id, fnWhere: fnWhere, afterChange: afterChange);
    }, suffixIcon: const Icon(AppIcons.chevron_right)),
  );
}

_onSelect(BuildContext context, String type, dynamic id,
    {bool Function(dynamic)? fnWhere, Function(dynamic)? afterChange}) async {
  List data = MasterDataService.data[type];
  if (fnWhere != null) {
    data = data.where(fnWhere!).toList();
  }
  var res = await showSearch(
      context: context, delegate: RxSelectDelegate(data: data, value: id));
  if (res != null) {
    if (afterChange != null) afterChange!(res);
  }
}

Widget RxBuildItemReview(ReviewModel item) {
  return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: [
              RxAvatarImage(item.rximguser, size: 25),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  item.username ?? "NaN",
                  style: const TextStyle().size(12),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBar.readOnly(
                filledColor: AppColors.yellow,
                size: 15,
                initialRating:
                    CommonMethods.convertToDouble(item.ratingvalue ?? 0.0),
                filledIcon: AppIcons.star_1,
                emptyIcon: AppIcons.star_1,
              ),
              const Spacer()
            ],
          ),
        ],
      ),
      // isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Text(item.comment ?? "",
              style: const TextStyle().italic, maxLines: 6),
          Text(item.rxtimeago, style: kTextTimeStyle),
        ],
      ));
}
