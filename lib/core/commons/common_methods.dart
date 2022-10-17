// ignore_for_file: empty_catches, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages, library_prefixes, unnecessary_null_comparison, non_constant_identifier_names

import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:new_version/new_version.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/firebase/dynamic_link.service.dart';
import 'package:raoxe/core/services/info_device.service.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'dart:convert' show base64, utf8;
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pipes/timeago/timeago.dart' as timeago;
import '../pipes/short_currency.dart' as shortCurrency;
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
import 'package:html/parser.dart';

class CommonMethods {
  static String getExtension(File file) {
    return p.extension(file.path);
  }

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

  static bool get isLogin {
    return APITokenService.token != null && APITokenService.token.isNotEmpty;
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
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  static int convertToInt32(dynamic pNumber, [int valuedefault = 0]) {
    try {
      return int.parse(pNumber.toString());
    } catch (e) {
      return valuedefault;
    }
  }

  static double convertToDouble(dynamic pNumber, [double valuedefault = 0]) {
    try {
      return double.parse(pNumber.toString());
    } catch (e) {
      return valuedefault;
    }
  }

  static String convertToString(dynamic pString, [String valuedefault = ""]) {
    try {
      return pString.toString();
    } catch (e) {
      return valuedefault;
    }
  }

  static bool convertToBoolean(dynamic pBoolean, [bool valuedefault = false]) {
    try {
      return pBoolean == 1 || pBoolean.toString().toLowerCase() == "true";
    } catch (e) {
      return valuedefault;
    }
  }

  static DateTime? convertToDateTime(String date,
      [String? newPattern, DateTime? valuedefault]) {
    try {
      return DateFormat(newPattern ?? "MM/dd/yyyy").parse(date);
    } catch (e) {}
    return valuedefault;
  }

  static String formatDateTime(DateTime? date,
      {String? newPattern, String valueDefault = ""}) {
    if (date != null) {
      try {
        return DateFormat(newPattern ?? "dd/MM/yyyy").format(date);
      } catch (e) {}
    }
    return valueDefault;
  }

  static String formatPhoneNumber(dynamic phone) {
    return phone.replaceAll(RegExp('[^0-9]'), '');
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
    Fluttertoast.showToast(
        msg: pmsg, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        backgroundColor:
            AppColors.secondary.withOpacity(0.7), //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 12.0 //message font size
        );
  }

  static Future<bool> showConfirmDialog(BuildContext context, String? content,
      {String? title}) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title ?? "notification".tr),
            content: content != null
                ? Text(
                    content,
                    style: const TextStyle(),
                  )
                : Container(),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "cancel".tr.toUpperCase(),
                  style: const TextStyle(color: AppColors.black50),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("ok".tr.toUpperCase()),
              )
            ],
          );
        });
  }

  static materialDialog(BuildContext context, dynamic pmsg,
      {String? title, List<Widget>? actions, Color? color}) async {
    String message = pmsg.toString();
    try {
      message = pmsg.message ?? message;
    } catch (e) {}
    return await Dialogs.materialDialog(
        msg: message,
        title: title ?? "notification".tr,
        context: context,
        actions: actions ??
            [
              TextButton(
                onPressed: () => CommonNavigates.goBack(context),
                child: Text("ok".tr.toUpperCase()),
              )
            ]);
  }

  static Future<void> showDialogInfo(BuildContext context, String pmsg,
      {List<Widget>? actions}) async {
    return await materialDialog(context, pmsg,
        title: "notification".tr, actions: actions, color: AppColors.info);
  }

  static Future<void> showDialogError(BuildContext context, dynamic pmsg,
      {String? title, List<Widget>? actions}) async {
    pmsg = pmsg.replaceAll("Exception: ", "").replaceAll("Exception", "");
    return await materialDialog(context, pmsg,
        actions: actions, color: AppColors.error);
  }

  static Future<void> showDialogSuccess(BuildContext context, Object pmsg,
      {String? title, List<Widget>? actions}) async {
    return await materialDialog(context, pmsg,
        actions: actions, color: AppColors.success);
  }

  static Future<void> showDialogWarning(BuildContext context, Object pmsg,
      {List<Widget>? actions}) async {
    return await materialDialog(context, pmsg,
        actions: actions, color: AppColors.warning);
  }

  static Future<void> showDialogCongratulations(
      BuildContext context, Object pmsg,
      {String? title, List<Widget>? actions}) async {
    return await Dialogs.materialDialog(
        color: AppColors.white,
        msg: pmsg.toString(),
        title: "congratulations".tr,
        lottieBuilder: Lottie.asset(
          'assets/congratulations.json',
          fit: BoxFit.contain,
        ),
        context: context,
        actions: [RxPrimaryButton(onTap: () {}, text: "done".tr)]);
  }

  static String buildUrlImage(int idHinh, {String? rewriteUrl, int size = 0}) {
    idHinh = idHinh > 0 ? idHinh : 0;
    rewriteUrl = rewriteUrl != null && rewriteUrl.isNotEmpty
        ? rewriteUrl
        : "image-dailyxe";
    rewriteUrl = rewriteUrl.convertrUrlPrefix();
    String url = '${CommonConfig.apiDrive}/image/$rewriteUrl-${idHinh}j.jpg';
    if (size > 0) {
      url = '$url?w=$size';
    }
    return url;
  }

  static String buildUrlHinhDaiDien(int idHinh,
      {String? rewriteUrl, int size = 240}) {
    if (idHinh > 0) {
      return buildUrlImage(idHinh, rewriteUrl: rewriteUrl, size: size);
    } else {
      return IMAGE_NOT_FOUND;
    }
  }

  static String buildUrlNews(int idNews,
      {String? rewriteUrl, String? prefixUrl}) {
    rewriteUrl = rewriteUrl!.convertrUrlPrefix();
    if (prefixUrl == "videos") {
      return '${CommonConfig.apiHost}/$prefixUrl/$rewriteUrl-${idNews}0.html';
    } else {
      return '${CommonConfig.apiHost}/$prefixUrl/$rewriteUrl-${idNews}d.html';
    }
  }

  static lockScreen() {
    EasyLoading.show(
        status: "${"awaiting".tr}...", maskType: EasyLoadingMaskType.custom);
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
    return "not.update".tr;
  }

  static String timeagoFormat(DateTime? time) {
    var strTimeAgo = "updating".tr;
    if (time == null) return strTimeAgo;
    if (time.toString() == "") return strTimeAgo;
    // try {
    //   var i = calculateDifference(time);
    //   final outputFormat = DateFormat('hh:mm a');
    //   var strTime = outputFormat.format(time).toLowerCase();
    //   if(time.hour == 0 && time.minute == 0 && time.second == 0)
    //   {
    //     strTime = "";
    //   }
    //   switch (i) {
    //     case 0:
    //       var _timeago = timeago.format(time, locale: 'vi');
    //       strTimeAgo = _timeago;//== "mới đây" ? _timeago : "Hôm nay $strTime";
    //       break;
    //     case -1:
    //       strTimeAgo = "Hôm qua $strTime";
    //       break;
    //     default:
    //       strTimeAgo = timeago.format(time, locale: 'vi');
    //   }
    // } catch (e) {}
    return timeago.format(time, locale: Get.locale!.languageCode ?? "en");
  }

  static formatShortCurrency(dynamic amount) {
    try {
      return shortCurrency.format(amount);
    } catch (e) {}
    return "not.update".tr;
  }

  static formatNumber(dynamic amount) {
    try {
      return NumberFormat.decimalPattern().format(int.parse(amount.toString()));
    } catch (e) {}
    return "not.update".tr;
  }

  static Future<T?> openWebView<T>(context,
      {String? url, String? title, String? html}) async {
    if (CommonMethods.isMobile()) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => RxWebView(
                  url: url, html: html, title: title ?? "content".tr)));
    } else {
      return CommonMethods.launchURL(url!);
    }
  }

  static Future<T?> openWebViewTermsAndCondition<T>(context) async {
    return openWebView(context,
        url: CommonConfig.linkContent["dieuKhoan"].toString(),
        title: "termsandcondition".tr);
  }

  static Future<T?> openWebViewPolicy<T>(context) async {
    return openWebView(context,
        url: CommonConfig.linkContent["chinhSach"].toString(),
        title: "policy".tr);
  }

  static Future<T?> openWebViewFeedBack<T>(context) async {
    return openWebView(context,
        url: CommonConfig.linkContent["feedBack"].toString(),
        title: "feedback".tr);
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

  static bool checkStringPhone(String? text) {
    if (text != null) {
      RegExp regExp = RegExp(
        RxParttern.phone,
        caseSensitive: false,
        multiLine: false,
      );
      return regExp.hasMatch(text);
    } else {
      return false;
    }
  }

  static bool checkStringEmail(String? text) {
    if (text != null) {
      RegExp regExp = RegExp(
        RxParttern.email,
        caseSensitive: false,
        multiLine: false,
      );
      return regExp.hasMatch(text);
    } else {
      return false;
    }
  }

  static format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  static convertTimeDuration(
      {int? days,
      int? hours,
      int? minutes,
      int? seconds,
      int? milliseconds,
      bool isTypeChar = false}) {
    try {
      var d = format(Duration(
        days: days ?? 0,
        hours: hours ?? 0,
        minutes: minutes ?? 0,
        seconds: seconds ?? 0,
        milliseconds: milliseconds ?? 0,
      ));
      d = d.toString();
      if (d == "00:00:00") return "";

      if (isTypeChar) {
        String _res = "";
        var ld = d.split(":");
        for (var i = 0; i < ld?.length; i++) {
          String item = ld[i];
          if (i == 0 && item != "00") {
            int h = int.parse(item);
            int day = h ~/ 24;
            int gio = h % 24;
            if (day > 0) {
              _res = '$day ngày';
            }
            if (gio > 0) {
              _res = '$_res $gio giờ';
            }
          }
          if (i == 1 && item != "00") {
            _res = '$_res $item phút';
          }
          if (i == 2 && item != "00") {
            _res = '$_res $item giây';
          }
        }
        return _res.trim();
      } else {
        while (d.indexOf("00:") == 0) {
          d = d.replaceFirst("00:", "");
        }
      }
      return d;
    } catch (e) {}
    return "";
  }

  static String getNameMasterById(String type, dynamic id) {
    try {
      if (type == "year") return id.toString();
      return (MasterDataService.data[type] as List)
          .firstWhere((element) => element["id"] == id)["name"];
    } catch (e) {
      return "";
    }
  }

  static List<T> convertToList<T>(List data, T Function(dynamic) toElement) {
    try {
      return data.map(toElement).toList();
    } catch (e) {
      return <T>[];
    }
  }

  static Future<bool> onFavorite(context, List<int> ids, bool status) async {
    try {
      if (!CommonMethods.isLogin) {
        CommonMethods.showToast("please.login".tr);
        return false;
      }
      ResponseModel res =
          await DaiLyXeApiBLL_APIUser().favoritepost(ids, status);
      if (res.status > 0) {
        status
            ? StorageService.addFavorite(ids)
            : StorageService.deleteFavorite(ids);
        return true;
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {}
    return false;
  }

  static Future<void> share(String linkShare, {String? subject}) async {
    await Share.share(linkShare, subject: subject);
  }

  //# build link dynamic
  static buildDynamicLink(String deepLink, [bool hasFl = false]) {
    if (deepLink == null) return "";
    try {
      //link: deeplink
      //apn: The package name of the Android app to use to open the link.
      //ibi: The bundle ID of the iOS app to use to open the link.
      //afl == ifl: The link to open when the app isn't installed.
      //&isi=${Variables.appStoreID}
      if (hasFl) {
        return '${CommonConfig.hostDynamicLink}/?link=$deepLink&apn=${InfoDeviceService.infoDevice.PackageInfo.packageName}&ibi=${InfoDeviceService.infoDevice.PackageInfo.packageName}&afl=$deepLink&ifl=$deepLink&isi=${CommonConfig.appStoreID}&efr=1';
      } else {
        return '${CommonConfig.hostDynamicLink}/?link=$deepLink&apn=${InfoDeviceService.infoDevice.PackageInfo.packageName}&ibi=${InfoDeviceService.infoDevice.PackageInfo.packageName}&isi=${CommonConfig.appStoreID}&efr=1';
      }
    } catch (error) {}
    return "";
  }

  static String linkProduct(int id, String rewriteUrl) {
    try {
      rewriteUrl = rewriteUrl.convertrUrlPrefix();
      String rewriteLink = '${CommonConfig.hostRaoXe}/$rewriteUrl-${id}r.html';
      return rewriteLink;
    } catch (error) {}
    return "";
  }

  static String linkNews(int id, String rewriteUrl) {
    try {
      rewriteUrl = rewriteUrl.convertrUrlPrefix();
      String rewriteLink =
          '${CommonConfig.hostDaiLyXe}/tin-tuc/$rewriteUrl-${id}d.html';
      return rewriteLink;
    } catch (error) {}
    return "";
  }

  static Future<Uri> buildDynamicLink_Product(ProductModel product) async {
    String deepLink = linkProduct(product.id, product.name!);
    return await createDynamicLink(deepLink);
  }

  static Future<Uri> createDynamicLink(String uriPrefix,
      {bool short = false, bool shareApp = false}) async {
    DynamicLinkParameters parameters;
    if (shareApp) {
      parameters = DynamicLinkParameters(
          uriPrefix: CommonConfig.hostDynamicLink,
          link: Uri.parse(uriPrefix),
          androidParameters: AndroidParameters(
            packageName: InfoDeviceService.infoDevice.PackageInfo.packageName,
            // minimumVersion: 16,
          ),
          // dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          //   shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
          // ),
          iosParameters: IOSParameters(
              bundleId: InfoDeviceService.infoDevice.PackageInfo.packageName,
              appStoreId: CommonConfig.appStoreID
              // minimumVersion: '16',
              ));
    } else {
      parameters = DynamicLinkParameters(
          uriPrefix: CommonConfig.hostDynamicLink,
          link: Uri.parse(uriPrefix),
          androidParameters: AndroidParameters(
            packageName: InfoDeviceService.infoDevice.PackageInfo.packageName,
            // minimumVersion: 16,
          ),
          // dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          //   shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
          // ),
          iosParameters: IOSParameters(
              bundleId: InfoDeviceService.infoDevice.PackageInfo.packageName,
              appStoreId: CommonConfig.appStoreID
              // minimumVersion: '16',
              ));
    }

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await DynamicLinkService.dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await DynamicLinkService.dynamicLinks.buildLink(parameters);
    }
    return url;
  }

  static String deepLinkInstallWithDomain() {
    try {
      String rewriteLink =
          '${CommonConfig.apiRaoXe}?appinstall=${generateMd5("d@i${APITokenService.userId}")}';
      return rewriteLink;
    } catch (error) {}
    return "";
  }

  static copy(BuildContext context, String noiDung) {
    Clipboard.setData(ClipboardData(text: noiDung)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to your clipboard !')));
    });
  }

  static void call(String phone) {
    phone = CommonMethods.formatPhoneNumber(phone);
    launchUrl(Uri.parse("tel://$phone"));
  }

  static void chatZalo(String phone) {
    phone = CommonMethods.formatPhoneNumber(phone);

    launchUrl(Uri.parse("https://zalo.me/$phone"),
        mode: LaunchMode.externalNonBrowserApplication);
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  //# build end link dynamic
  static getInfoRewriteLinkWithDomain(String linkRewriteWithDomain) {
    try {
      String regexString = r"-(\d+)(\w)\.html"; // not r'/api/\w+/\d+/' !!!
      RegExp regExp = RegExp(regexString);
      var matches = regExp.firstMatch(linkRewriteWithDomain);
      return {
        "id": int.parse(matches!.group(1)!),
        "typePage": matches.group(2)
      };
    } catch (e) {}
    return null;
  }
}
