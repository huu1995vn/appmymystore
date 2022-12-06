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
import 'package:mymystore/core/components/delegates/rx_select.delegate.dart';
import 'package:mymystore/core/components/index.dart';
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
  return ListTile(
    leading: icon,
    title: Text(title),
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

class MMWebView extends StatefulWidget {
  String? url;
  String? title;
  Widget? action;
  String? javaScriptString;
  String? html;
  MMWebView(
      {super.key,
      this.url,
      this.title,
      this.action,
      this.javaScriptString,
      this.html});
  @override
  MMWebViewState createState() => MMWebViewState();
}

class MMWebViewState extends State<MMWebView> {
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title ?? ""),
          elevation: 0.0,
          actions: [widget.action ?? Container()],
        ),
        body: Stack(
          children: <Widget>[
            widget.html != null && widget.html!.isNotEmpty
                ? InAppWebView(
                    key: _key,
                    initialData: InAppWebViewInitialData(data: widget.html!),
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
          height: 10,
        ),
        Text(
          message ?? "no.found".tr,
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
            Text(
              'message.str006'.tr,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Text(
              "login".tr,
              style: TextStyle(
                  color: AppColors.primary.withAlpha(500),
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
  const MMAvatarImage(this.url, {Key? key, this.border, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        image: DecorationImage(
          image: MMImageProvider(url),
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
    //     child: MMCircleAvatar(
    //         backgroundImage: MMImageProvider(url)));
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
          borderRadius: BorderRadius.circular(radius ?? CommonConstants.kDefaultPadding),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: color),
      ),
    );
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
        height: CommonConstants.kSizeHeight,
        child: icon == null
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                    backgroundColor: color //elevated btton background color
                    ),
                child: Text(text,
                    style: const TextStyle(
                      color: CommonConstants.kWhite,
                      fontSize: 16,
                    )),
              )
            : ElevatedButton.icon(
                onPressed: onTap,
                icon: icon!, //icon data for elevated button
                label: Text(text,
                    style: const TextStyle(
                      color: CommonConstants.kWhite,
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
          padding: const EdgeInsets.only(
              top: CommonConstants.kDefaultPadding,
              bottom: CommonConstants.kDefaultPadding,
              left: CommonConstants.kDefaultPaddingBox,
              right: CommonConstants.kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: color ?? Colors.grey[200],
          ),
          child: Row(
            children: [
              Text(
                text,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
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

Widget rxTextInput(BuildContext context, String? value,
    {Widget? title,
    String? hintText,
    String? labelText,
    bool isBorder = false,
    TextInputType? keyboardType = TextInputType.text,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    void Function()? onTap,
    int? maxLength,
    int? minLines,
    MaxLengthEnforcement? maxLengthEnforcement}) {
  return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      child: ListTile(
          title: title ??
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: labelText ?? "",
                        style: CommonConstants.kTextTitleStyle.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 12)),
                    if (validator != null)
                      const TextSpan(
                          text: ' *',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary)),
                  ],
                ),
              ),
          subtitle: SizedBox(
            height: validator != null ? null : 35,
            child: MMInput(value ?? "",
                readOnly: onTap != null,
                isBorder: isBorder,
                keyboardType: keyboardType,
                onChanged: onChanged,
                hintText: hintText,
                onTap: onTap,
                style: const TextStyle().size(16),
                maxLength: maxLength,
                minLines: minLines,
                maxLengthEnforcement: maxLengthEnforcement,
                validator: validator),
          )));
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
  if (id == -1) {
    name = "all".tr;
  }
  return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      child: ListTile(
        title: title ??
            RichText(
              text: TextSpan(
                // text: lableText ?? type.tr(),
                children: <TextSpan>[
                  TextSpan(
                      text: labelText ?? type.tr,
                      style: CommonConstants.kTextTitleStyle.copyWith(
                          fontSize: 12,
                          color:
                              Theme.of(context).textTheme.labelLarge!.color)),
                  if (validator != null)
                    const TextSpan(
                        text: ' *',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary)),
                ],
              ),
            ),
        subtitle: SizedBox(
          height: validator != null ? null : 35,
          child: MMInput(name,
              isBorder: isBorder,
              readOnly: true,
              hintText: hintText ?? "choose".tr,
              style: const TextStyle(fontSize: 16),
              validator: validator, onTap: () {
            _onSelect(context, type, id,
                fnWhere: fnWhere, afterChange: afterChange);
          }),
        ),
        trailing: const Icon(AppIcons.chevron_right),
      ));
}

_onSelect(BuildContext context, String type, dynamic id,
    {bool Function(dynamic)? fnWhere, Function(dynamic)? afterChange}) async {
  List data = [];
  if (type == "year") {
    int start = 1970;
    for (var i = DateTime.now().year + 1; i >= start; i--) {
      data.add({"name": i.toString(), "id": i});
    }
  } else {
    data = MasterDataService.data[type];
  }
  if (fnWhere != null) {
    data = data.where(fnWhere).toList();
  }

  data = [
    {"name": "all".tr, "id": -1},
    ...data
  ];
  var res = await showSearch(
      context: context, delegate: MMSelectDelegate(data: data, value: id));
  if (res != null) {
    if (afterChange != null) afterChange(res);
  }
}

Widget MMBorderListTile({Widget? child}) {
  return Container(
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


Widget MMGoBack(context) {
  return 
  IconButton(
    icon: const Icon(Icons.chevron_left, color: AppColors.primary, size: 24,),
    onPressed: () => Navigator.of(context).pop(),
  );
}
