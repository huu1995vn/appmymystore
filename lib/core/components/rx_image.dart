// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/components/part.dart';
import 'package:mymystore/core/commons/common_constants.dart';

class MMImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool fullHeight;
  MMImage(this.url,
      {Key? key,
      this.width,
      this.height,
      this.fullHeight = true,
      this.fit = BoxFit.cover})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Image.asset(
        CommonConstants.IMAGE_NO,
        fit: fit,
        width: width,
        height: height,
      );
    }
    if (CommonMethods.isURl(url)) {
      return CommonConfig.haveCacheImage
          ? CachedNetworkImage(
              imageUrl: url,
              width: width ?? MediaQuery.of(context).size.width,
              height: fullHeight ? MediaQuery.of(context).size.height : height,
              fit: fit,
              errorWidget: (context, url, error) => const Icon(AppIcons.sad),
            )
          : FadeInImage(
              width: width ?? MediaQuery.of(context).size.width,
              height: fullHeight ? MediaQuery.of(context).size.height : height,
              placeholder: MemoryImage(KTRANSPARENTIMAGE),
              image: MMImageProvider(url),
              fit: fit,
            );
    } else {
      if (url.contains("assets/")) {
        return Image.asset(
          url,
          width: width ?? MediaQuery.of(context).size.width,
          height: fullHeight ? MediaQuery.of(context).size.height : height,
          fit: fit,
        );
      } else {
        dynamic img =
            (url.indexOf("/storage") == 0 || url.indexOf("/data") == 0)
                ? FileImage(File(url))
                : AssetImage(url);
        return FadeInImage(
          width: width ?? MediaQuery.of(context).size.width,
          height: fullHeight ? MediaQuery.of(context).size.height : height,
          placeholder: MemoryImage(KTRANSPARENTIMAGE),
          image: img,
          fit: fit,
        );
      }
    }
  }

  final Uint8List KTRANSPARENTIMAGE = Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);
}
