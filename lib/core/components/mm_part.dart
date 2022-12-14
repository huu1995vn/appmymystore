// ignore_for_file: non_constant_identifier_names, must_be_immutable, import_of_legacy_library_into_null_safe, overridden_fields, empty_catches, unnecessary_null_comparison

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/delegates/mm_select.delegate.dart';
import 'package:mymystore/core/components/index.dart';
import 'package:mymystore/core/components/mm_text_avatar.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/master_data.service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/utilities/extensions.dart';
import 'package:mymystore/core/utilities/size_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MMDivider extends Divider {
  const MMDivider({super.key, double indent = 20})
      : super(indent: indent, endIndent: indent, height: 1, thickness: 1);
}

Widget MMBuildItem(
    {required String title,
    Widget? icon,
    void Function()? onTap,
    Widget? trailing}) {
  return MMListTile(
    leading: icon,
    title: MMText(data: title),
    trailing: trailing,
    onTap: onTap,
  );
}

class MMDisabled extends StatelessWidget {
  final Widget child;
  final bool disabled;

  const MMDisabled({Key? key, this.disabled = false, required this.child})
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

class MMHtmlView extends StatefulWidget {
  String? url;
  String? javaScriptString;
  String? html;
  MMHtmlView({super.key, this.url, this.javaScriptString, this.html});
  @override
  MMHtmlViewState createState() => MMHtmlViewState();
}

class MMHtmlViewState extends State<MMHtmlView> {
  final _key = UniqueKey();
  bool isLoading = true;
  late InAppWebViewController _controller;
  @override
  void initState() {
    super.initState();
  }

  Size get screenSize => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    // bool ishtml = widget.html != null && widget.url == null;
    return Stack(
      children: <Widget>[
        widget.url != null && widget.url!.isNotEmpty
            ? InAppWebView(
                key: _key,
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url!)),
                onWebViewCreated: (InAppWebViewController controller) {
                  _controller = controller;
                },
                onProgressChanged: (controller, progress) {
                  if (progress > 20) {
                    if (isLoading) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    if (_controller != null &&
                        widget.javaScriptString != null) {
                      _controller.evaluateJavascript(
                          source: widget.javaScriptString!);
                    }
                  }
                },
              )
            : InAppWebView(
                key: _key,
                initialData: InAppWebViewInitialData(data: widget.html ?? ""),
                onWebViewCreated: (InAppWebViewController controller) {
                  _controller = controller;
                },
                onProgressChanged: (controller, progress) {
                  if (progress > 20) {
                    if (isLoading) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    if (_controller != null &&
                        widget.javaScriptString != null) {
                      _controller.evaluateJavascript(
                          source: widget.javaScriptString!);
                    }
                  }
                },
              ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(),
      ],
    );
  }
}

class MMCustomShape extends CustomClipper<Path> {
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


Widget MMNoFound({required String urlImage, String? message}) {
  return SizedBox(
    height: SizeConfig.screenHeight -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        25,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MMImage(
          urlImage,
          fullHeight: false,
        ),
        const SizedBox(
          height: CommonConstants.kDefaultMargin,
        ),
        MMText(
          data: message ?? "no.found".tr,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget MMLoginAccountLabel(context) {
  return InkWell(
    onTap: () {
      CommonNavigates.toLoginPage(context);
    },
    child: Padding(
      padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MMText(
              data: 'message.str006'.tr,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            MMText(
              data: "login".tr,
              style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ),
  );
}

class MMAvatarImage extends StatelessWidget {
  final String url;
  final double size;
  final BoxBorder? border;
  const MMAvatarImage(this.url, {Key? key, this.border, this.size = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.5),
        image: DecorationImage(
          image: MMImageProvider(url),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(size / 2)),
        border: border ??
            Border.all(
              color: AppColors.white,
              width: 1.0,
            ),
      ),
    );
  }
}

class MMCircleAvatar extends CircleAvatar {
  const MMCircleAvatar(
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

ImageProvider<Object> MMImageProvider(String url) {
  if (url.isEmpty) {
    url = CommonConstants.IMAGE_NO;
  }
  if (CommonMethods.isURl(url)) {
    if (true) {
      return CachedNetworkImageProvider(url);
    } 
    // else 
    // {
    //   return NetworkImage(url);
    // }
  } else {
    if (url.contains("assets/")) {
      return AssetImage(url);
    }
    return FileImage(File(url));
  }
}

class MMSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MMSliverPersistentHeaderDelegate(this._tabBar);

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
  bool shouldRebuild(MMSliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class MMSliverAppBarTabDelegate extends SliverPersistentHeaderDelegate {
  PreferredSize? child;

  MMSliverAppBarTabDelegate({this.child});

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

class MMRoundedButton extends StatelessWidget {
  const MMRoundedButton({
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
        side: BorderSide(width: 1.0, color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? CommonConstants.kDefaultRadius),
        ),
      ),
      child: MMText(
        data: title,
        style: TextStyle(color: color),
      ),
    );
  }
}

class MMCard extends Card {
  const MMCard({
    super.key,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin = const EdgeInsets.only(bottom: CommonConstants.kDefaultPadding),
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(borderOnForeground != null);

  final Color? color;

  final Color? shadowColor;

  final Color? surfaceTintColor;

  final double? elevation;

  final ShapeBorder? shape;

  final bool borderOnForeground;

  final Clip? clipBehavior;

  final EdgeInsetsGeometry? margin;

  final bool semanticContainer;

  final Widget? child;
}

class MMListTile extends ListTile {
  const MMListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.visualDensity,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.contentPadding = const EdgeInsets.all(0),
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
  });

  @override
  final Widget? leading;
  @override
  final Widget? title;
  @override
  final Widget? subtitle;
  @override
  final Widget? trailing;
  @override
  final bool isThreeLine;
  @override
  final bool? dense;
  @override
  final VisualDensity? visualDensity;
  @override
  final ShapeBorder? shape;
  @override
  final Color? selectedColor;
  @override
  final Color? iconColor;

  @override
  final Color? textColor;
  @override
  final ListTileStyle? style;
  @override
  final EdgeInsetsGeometry contentPadding;
  @override
  final bool enabled;
  @override
  final GestureTapCallback? onTap;
  @override
  final GestureLongPressCallback? onLongPress;
  @override
  final MouseCursor? mouseCursor;
  @override
  final bool selected;
  @override
  final Color? focusColor;
  @override
  final Color? hoverColor;
  @override
  final Color? splashColor;
  @override
  final FocusNode? focusNode;
  @override
  final bool autofocus;
  @override
  final Color? tileColor;
  @override
  final Color? selectedTileColor;
  @override
  final bool? enableFeedback;
  @override
  final double? horizontalTitleGap;
  @override
  final double? minVerticalPadding;
  @override
  final double? minLeadingWidth;
}

class MMText extends StatefulWidget {
  final String? data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final Color? selectionColor;
  const MMText(
      {this.data,
      super.key,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.selectionColor});
  @override
  State<StatefulWidget> createState() {
    return _MMTextState();
  }
}

class _MMTextState extends State<MMText> {
  String data = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      data = widget.data ?? "";
    });
  }

  @override
  void didUpdateWidget(MMText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      Future.delayed(Duration.zero, () {
        if (mounted && widget.data != data) {
          setState(() {
            data = widget.data!;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(data,
        key: widget.key,
        style: widget.style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: widget.textScaleFactor,
        maxLines: widget.maxLines,
        semanticsLabel: widget.semanticsLabel,
        textWidthBasis: widget.textWidthBasis,
        selectionColor: widget.selectionColor);
  }
}

class MMPrimaryButton extends MMButton {
  const MMPrimaryButton(
      {super.key, required this.onTap, required this.text, this.icon})
      : super(onTap: onTap, text: text);
  @override
  final GestureTapCallback onTap;
  @override
  final String text;
  @override
  final Widget? icon;
}

class MMButton extends StatelessWidget {
  const MMButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color,
    this.icon,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String text;
  final Color? color;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:  CommonConstants.kSizeHeight,
        child: icon == null
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                    backgroundColor: color //elevated btton background color
                    ),
                child: MMText(
                    data: text,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    )),
              )
            : ElevatedButton.icon(
                onPressed: onTap,
                icon: icon!, //icon data for elevated button
                label: MMText(
                    data: text,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    )), //label text
                style: ElevatedButton.styleFrom(
                    backgroundColor: color //elevated btton background color
                    ),
              ));
  }
}

class MMButtonMore extends StatelessWidget {
  const MMButtonMore({
    Key? key,
    required this.onTap,
    required this.text,
    this.color,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: color ?? Colors.grey[200],
          ),
          child: Row(
            children: [
              MMText(
                data: text,
                style: CommonConstants.kTextSubTitleStyle,
              ),
              const SizedBox(
                width: CommonConstants.kDefaultPadding,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    AppIcons.chevron_right,
                    color: Colors.black,
                  )),
            ],
          ),
        ));
  }
}

Widget MMListAwaiting() {
  return ListView.builder(
      key: UniqueKey(),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: CommonConstants.kDefaultMargin),
      itemCount: CommonConstants.kItemOnPage,
      itemBuilder: (context, index) {
        return Container();
      });
}

Widget MMBorder({Widget? child}) {
  return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border(
          bottom: Get.isDarkMode
              ? const BorderSide(
                  color: Color.fromARGB(12, 255, 255, 255), width: 1)
              : const BorderSide(color: Color.fromARGB(12, 0, 0, 0), width: 1),
        ),
      ),
      child: child);
}


Widget Avatar(int id, String name, {double size = 16, BoxBorder? border}) {
  border = border ??
      Border.all(
        color: AppColors.white,
        width: size == CommonConstants.kSizeAvatarSmall ? 1 : 3,
      );
  try {
    if (id > 0) {
      return MMAvatarImage(
          CommonMethods.buildUrlHinhDaiDien(id, rewriteUrl: name),
          size: size,
          border: border);
    }
  } catch (e) {
    CommonMethods.wirtePrint(e);
  }
  return MMTextAvatar(
      text: name ?? "R", shape: Shape.Circular, size: size, border: border);
}
