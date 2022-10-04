// ignore_for_file: unused_element, empty_catches

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/services/info_device.service.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class DynamicLinkService {
  static FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  static Future<Uri> createDynamicLink(String link) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: CommonConfig.hostDynamicLink,
      link: Uri.parse(link),
      androidParameters: AndroidParameters(
        packageName: InfoDeviceService.infoDevice.PackageInfo.packageName,
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        bundleId: InfoDeviceService.infoDevice.PackageInfo.packageName,
        minimumVersion: '1',
        appStoreId: CommonConfig.appStoreID,
      ),
    );
    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri shortUrl = shortLink.shortUrl;
    return shortUrl;
  }

  static _deepLink(context, Uri uriLink) {
    String deepLink = '${uriLink.origin}${uriLink.path}';
    if (uriLink.query.isNotNullEmpty) {
      deepLink += '?${uriLink.query}';
    }

    var resInfo = _getInfoRewriteLinkWithDomain(deepLink);
    if (resInfo != null) {
      switch (resInfo["typePage"]) {
        case "rm":
          CommonNavigates.toProductPage(context,
              id: int.parse(resInfo["id"].toString()));
          break;
      }
    }
  }

  static _getInfoRewriteLinkWithDomain(String linkRewriteWithDomain) {
    try {
      String regexString = r"-(\d+)(\w)\.html"; // not r'/api/\w+/\d+/' !!!
      RegExp regExp = RegExp(regexString);
      var matches = regExp.firstMatch(linkRewriteWithDomain);
      return {
        "id": int.parse(matches!.group(1).toString()),
        "typePage": matches.group(2)
      };
    } catch (e) {}
    return null;
  }
}
