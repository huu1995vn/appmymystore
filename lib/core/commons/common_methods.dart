// ignore_for_file: empty_catches

import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:new_version/new_version.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'dart:convert' show base64, utf8;
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pipes/timeago/timeago.dart' as timeago;

class CommonMethods {
  static bool isURl(String str) {
    return Uri.parse(str).isAbsolute;
  }

  static wirtePrint(Object object) {
    if (kDebugMode) {
      if (object is StateError) {
        print(object.message);
      } else {
        print(object.toString());
      }
    }
  }

  static get isLogin {
    return false;
  }

  static Future<PackageInfo?> getPackageInfo() async {
    try {
      return await PackageInfo.fromPlatform();
    } catch (e) {}
    return null;
  }

  static Future<String> getIPv4() async {
    try {
      List<NetworkInterface> lNetworkInterface = await NetworkInterface.list();
      var interface = lNetworkInterface[0];
      return interface.addresses[0].address;
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return "";
  }

  static Future<Position?> getPosition() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied &&
          StorageService.get("isOpened") != null) {
        StorageService.set("isOpened", true);
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          Future.error('Location Not Available');
          return null;
        }
      } else {
        return await Geolocator.getCurrentPosition();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static DateTime? convertToDateTime(String date, [String? newPattern]) {
    try {
      return DateFormat(newPattern ?? "MM/dd/yyyy").parse(date);
    } catch (e) {}
    return null;
  }

  static String formatDateTime(DateTime? date, [String? newPattern]) {
    if (date != null) {
      try {
        return DateFormat(newPattern ?? "dd/MM/yyyy").format(date!);
      } catch (e) {}
    }
    return "";
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString().toUpperCase();
  }

  static String encodeBase64Utf8(String text) {
    return utf8.fuse(base64).encode(text);
  }

  static String decodeBase64Utf8(String text) {
    return utf8.fuse(base64).decode(text);
  }

  static showToast(String pmsg) {
    EasyLoading.showToast(pmsg,
        toastPosition: EasyLoadingToastPosition.bottom,
        maskType: EasyLoadingMaskType.black);
  }

  static showDialog(BuildContext context, String pmsg,
      {String? title, List<Widget>? actions, Color color = AppColors.white}) {
    Dialogs.materialDialog(
        msg: pmsg,
        title: title ?? "notification".tr(),
        color: color,
        context: context,
        actions: actions ??
            [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.done, color: AppColors.white),
                color: AppColors.primary,
              )
            ]);
  }

  static void showDialogInfo(BuildContext context, String pmsg,
      {List<Widget>? actions}) {
    showDialog(context, pmsg,
        title: "notification.text".tr(),
        actions: actions,
        color: AppColors.info);
  }

  static void showDialogError(BuildContext context, String pmsg,
      {String? title, List<Widget>? actions}) {
    showDialog(context, pmsg,
        title: "success.text".tr(), actions: actions, color: AppColors.error);
  }

  static void showDialogSuccess(BuildContext context, String pmsg,
      {String? title, List<Widget>? actions}) {
    showDialog(context, pmsg,
        title: "success.text".tr(), actions: actions, color: AppColors.success);
  }

  static void showDialogWarning(BuildContext context, String pmsg,
      {List<Widget>? actions}) {
    showDialog(context, pmsg,
        title: "warning".tr(), actions: actions, color: AppColors.warning);
  }

  static void showDialogCongratulations(BuildContext context, String pmsg,
      {String? title, List<Widget>? actions}) {
    Dialogs.materialDialog(
        color: AppColors.white,
        msg: pmsg,
        title: "congratulations".tr(),
        lottieBuilder: Lottie.asset(
          'assets/congratulations.json',
          fit: BoxFit.contain,
        ),
        context: context,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done, color: AppColors.white),
            color: AppColors.primary,
          ),
        ]);
  }

  static String buildUrlImage(int idHinh,
      {String? rewriteUrl, prefixSize = 0}) {
    prefixSize = prefixSize ?? "";
    if (prefixSize is! String) {
      prefixSize = prefixSize.toString();
    }
    idHinh = idHinh > 0 ? idHinh : 0;
    rewriteUrl = rewriteUrl!.isNotEmpty ? rewriteUrl : "image-dailyxe";
    rewriteUrl = rewriteUrl.convertrUrlPrefix();
    return '${CommonConfig.apiDrive}/image/$rewriteUrl-${idHinh}j$prefixSize.jpg';
  }

  static String buildUrlHinhDaiDien(int idHinh,
      {String? rewriteUrl, prefixSize = 0}) {
    return buildUrlImage(idHinh,
        rewriteUrl: rewriteUrl, prefixSize: prefixSize);
  }

  static lockScreen() {
    EasyLoading.show(
        status: "${"awaiting".tr()}...", maskType: EasyLoadingMaskType.custom);
  }

  static unlockScreen() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  static bool isMobile() {
    return UniversalPlatform.isAndroid || UniversalPlatform.isIOS;
  }

  static launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  static String formatDate(date, [String pattern = 'dd/MM/yyyy HH:mm:ss']) {
    DateTime d;
    try {
      d = date is DateTime ? date : DateTime.parse(date);
      return DateFormat(pattern).format(d);
    } catch (e) {}
    return "not.update".tr();
  }

  static String timeagoFormat(DateTime? time) {
    var strTimeAgo = "updating".tr();
    if(time==null) return strTimeAgo;
    if (time.toString() == "") return strTimeAgo;
    try {
      var i = calculateDifference(time);
      final outputFormat = DateFormat('hh:mm a');
      var strTime = outputFormat.format(time).toLowerCase();
      switch (i) {
        case 0:
          var _timeago = timeago.format(time, locale: 'vi');
          strTimeAgo = _timeago == "mới đây" ? _timeago : "Hôm nay $strTime";
          break;
        case -1:
          strTimeAgo = "Hôm qua $strTime";
          break;
        default:
          strTimeAgo = timeago.format(time, locale: 'vi');
      }
    } catch (e) {}
    return strTimeAgo;
  }

 

  static Future<T?> openWebView<T>(context, String url, {String? title}) async {
    if (CommonMethods.isMobile()) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => RxWebView(url: url, title: title)));
    } else {
      return CommonMethods.launchURL(url);
    }
  }

  static Future<T?> openWebViewTermsAndCondition<T>(context) async {
    return openWebView(
        context, CommonConfig.linkContent["dieuKhoan"].toString(),
        title: "termsandcondition".tr());
  }

  static Future<T?> openWebViewPolicy<T>(context) async {
    return openWebView(
        context, CommonConfig.linkContent["chinhSach"].toString(),
        title: "policy".tr());
  }

  static Future<T?> openWebViewFeedBack<T>(context) async {
    return openWebView(context, CommonConfig.linkContent["feedBack"].toString(),
        title: "feedback".tr());
  }

  static versionCheck(context) async {
    if (CommonConfig.env == "prod") {
      final NewVersion newVersion = NewVersion();
      VersionStatus? versionStatus = await newVersion.getVersionStatus();
      if (versionStatus != null && versionStatus.canUpdate) {
        newVersion.showUpdateDialog(
            context: context,
            versionStatus: versionStatus,
            allowDismissal: false);
      }
    }
  }
}
