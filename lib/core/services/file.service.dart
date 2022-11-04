// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_null_comparison, null_check_always_fails

import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymystore/core/api/drive/drive_api.bll.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/utilities/extensions.dart';
import 'package:universal_platform/universal_platform.dart';

class FileService {
  static Future<int> uploadImage(File f,
      {int idFile = -1, String name = ""}) async {
    var extension = CommonMethods.getExtension(f);
    ResponseModel res =
        await DriveApiBLL_ApiFile().uploadfile(f, idFile, "$name$extension");
    if (!(res.status > 0)) throw res.message;
    return res.data;
  }

  static Future<String> getImagePicker(context,
      {bool cropImage = false, bool circleShape = false}) async {
    if (!CommonMethods.isMobile()) {
      throw "Chức năng không hỗ trợ thiết bị này";
    }
    List<String> lfile = await getMultiImagePicker(context, single: true);
    if (lfile != null && lfile.isNotEmpty) {
      return lfile[0];
    }
    return null!;
  }

  static Future<List<String>> getMultiImagePicker(context,
      {bool single = false, int maxImages = 1}) async {
    maxImages = single ? 1 : maxImages;
    int? action;
    try {
      if (UniversalPlatform.isIOS) {
        action = await showCupertinoModalPopup<int>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              title: Text("choose.imagesource".tr),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Row(
                    children: <Widget>[
                      // Icon(Icon, color: AppColors.black50),
                      Text("camera".tr)
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
                      Text("gallery".tr)
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
                    // RxIcon(AppIcons.cross, color: Colors.grey),
                    Text("cancel".tr)
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
                        children: <Widget>[Text("camera".tr)],
                      )),
                  ListTile(
                      onTap: () {
                        return Navigator.pop(context, 2);
                      },
                      // leading:
                      //     RxIcon(LineAwesomeIcons.image, color: Colors.grey),
                      title: Row(
                        children: <Widget>[Text("gallery".tr)],
                      )),
                  ListTile(
                      onTap: () {
                        return Navigator.pop(context, null);
                      },
                      // leading: RxIcon(AppIcons.cross, color: Colors.grey),
                      title: Row(
                        children: <Widget>[Text("cancel".tr)],
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

  static Future<List<String>> openCamera() async {
    try {
      // ignore: deprecated_member_use
      XFile? pickImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (pickImage == null) return [];
      return [pickImage.path];
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return [];
  }

  static Future<List<String>> openGallery({int maxImages = 1}) async {
    try {
      List<XFile>? pickedFiles =
          await ImagePicker().pickMultiImage(imageQuality: 70, maxWidth: 1440);
      if (pickedFiles == null || pickedFiles.isEmpty) return [];
      List<String> img =
          pickedFiles.map((pickImage) => pickImage.path).toList();
      if (img == null || img.isEmpty) return <String>[];
      return img.sublist(0, img.length >= maxImages ? maxImages : img.length);
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return [];
  }

  static Future<int> uploadImageByPath(String path, {String? name}) async {
    int idFileDaiDien = -1;
    if (Uri.parse(path).isAbsolute) {
      idFileDaiDien = path.getIdFile();
    }
    if (idFileDaiDien > 0) {
      return idFileDaiDien;
    }
    File file = File(path);
    return await uploadImage(file, name: name!);
  }

  static Future<List<int>> convertListHinhAnhToListInt(List<String> listPath,
      {String? name}) async {
    List<Future<int>> listApi =
        listPath.map((url) => uploadImageByPath(url, name: name)).toList();
    return await Future.wait(listApi);
  }
}
