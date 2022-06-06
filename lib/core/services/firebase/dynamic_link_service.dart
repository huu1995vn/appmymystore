import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:raoxe/core/commons/common_configs.dart';

class DynamicLinkService {
  
  Future<Uri> createDynamicLink(String link) async {
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: CommonConfig.uriPrefixDynamicLink,
        link: Uri.parse(link),
        androidParameters: AndroidParameters(
          packageName: infoDevice.PackageInfo.packageName,
          minimumVersion: 1,
        ),
        iosParameters: IOSParameters(
          bundleId: infoDevice.PackageInfo.packageName,
          minimumVersion: '1',
          appStoreId: CommonConfig.appStoreID,
        ),
      );
      final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
      final Uri shortUrl = shortLink.shortUrl;
      return shortUrl;
  }
  
}