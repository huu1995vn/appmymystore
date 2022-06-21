// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:raoxe/core/api/drive/drive_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/entities.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<int> uploadImage(File f, {int idFile = -1, String name = ""}) async {
    var extension = CommonMethods.getExtension(f);
    ResponseModel res =
        await DriveApiBLL_ApiFile().uploadfile(f, idFile, "$name$extension");
    if (!(res.status > 0)) throw res.message;
    return res.data;
  }

  static Future<File?> getImagePicker(context,
      {bool cropImage = false, bool circleShape = false}) async {
    if (!CommonMethods.isMobile()) {
      throw "Chức năng không hỗ trợ thiết bị này";
    }
    List<File> lfile = await getMultiImagePicker(context, single: true);
    if (lfile != null && lfile.isNotEmpty) {
      return lfile[0];
    }
    return null;
  }

  static Future<List<File>> getMultiImagePicker(context,
      {bool single = false, int maxImages = 1}) async {
    maxImages = single ? 1 : maxImages;
    int? action;
    try {
      if (UniversalPlatform.isIOS) {
        action = await showCupertinoModalPopup<int>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              title: Text("choose.imagesource".tr()),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Row(
                    children: <Widget>[
                      // Icon(Icon, color: AppColors.black50),
                      Text("camera".tr())
                    ],
                  ),
                  onPressed: () {
                    return Navigator.pop(context, 1);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Row(
                    children: <Widget>[
                      // RxIcon(LineAwesomeIcons.envira_gallery,
                      //     color: Colors.grey),
                      Text("gallery".tr())
                    ],
                  ),
                  onPressed: () {
                    return Navigator.pop(context, 2);
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                isDefaultAction: true,
                child: Row(
                  children: <Widget>[
                    // RxIcon(Icons.close, color: Colors.grey),
                    Text("cancel".tr())
                  ],
                ),
                onPressed: () {
                  return Navigator.pop(context, null);
                },
              ),
            );
          },
        );
      } else {
        action = await showModalBottomSheet<int>(
          context: context,
          builder: (BuildContext context) {
            return Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Wrap(children: <Widget>[
                  ListTile(
                      onTap: () {
                        return Navigator.pop(context, 1);
                      },
                      // leading:
                      //     Icon(LineAwesomeIcons.camera, color: Colors.grey),
                      title: Row(
                        children: <Widget>[Text("camera".tr())],
                      )),
                  ListTile(
                      onTap: () {
                        return Navigator.pop(context, 2);
                      },
                      // leading:
                      //     RxIcon(LineAwesomeIcons.image, color: Colors.grey),
                      title: Row(
                        children: <Widget>[Text("gallery".tr())],
                      )),
                  ListTile(
                      onTap: () {
                        return Navigator.pop(context, null);
                      },
                      // leading: RxIcon(Icons.close, color: Colors.grey),
                      title: Row(
                        children: <Widget>[Text("cancel".tr())],
                      )),
                ]));
          },
        );
      }
      switch (action) {
        case 1:
          return await openCamera();
        case 2:
          return await openGallery(maxImages: maxImages);
        default:
      }
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }

    return [];
  }

  static Future<List<File>> openCamera() async {
    try {
      // ignore: deprecated_member_use
      final pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
      );
      if (pickedFile == null) return [];
      return [File(pickedFile.path)];
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return [];
  }

  static Future<List<File>> openGallery({int maxImages = 1}) async {
    try {
      List<Asset> assetArray = <Asset>[];
      assetArray = await MultiImagePicker.pickImages(
        maxImages: maxImages,
        enableCamera: true,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarTitle: "gallery".tr(),
          allViewTitle: "all".tr(),
          actionBarColor: "#b71c1c",
          statusBarColor: "#b71c1c",
          useDetailsView: false,
          selectCircleStrokeColor: "#ffffff",
          // startInAllView: true
        ),
      );
      if (assetArray == null || assetArray.isEmpty) return [];
      List<File> img = await _convertToListFile(assetArray);
      if (img == null || img.isEmpty) return null!;
      return img.sublist(0, img.length >= maxImages ? maxImages : img.length);
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return [];
  }

  static Future<List<File>> _convertToListFile(List<Asset> assetArray) async {
    List<File> fileImageArray = [];
    try {
      for (var i = 0; i < assetArray.length; i++) {
        var imageAsset = assetArray[i];
        File tempFile = await _convertToFile(imageAsset);
        if (tempFile.existsSync()) {
          fileImageArray.add(tempFile);
        }
      }
    } catch (e) {}

    return fileImageArray;
  }

  static Future<File> _convertToFile(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }
}
