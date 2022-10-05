// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';

class PhotoViewDialog extends StatefulWidget {
  const PhotoViewDialog(
      {super.key,
      required this.imgs,
      this.onDelete,
      this.initialPage = 0,
      this.title});
  final List<String> imgs;
  final void Function(int)? onDelete;
  final int initialPage;
  final String? title;
  @override
  State<PhotoViewDialog> createState() => _PhotoViewDialogState();
}

class _PhotoViewDialogState extends State<PhotoViewDialog> {
  @override
  void initState() {
    super.initState();
    setState(() {
      imgs = widget.imgs;
      initialPage = widget.initialPage;
    });
  }

  List<String>? imgs;
  int initialPage = 0;
  onDelete() {
    if (widget.onDelete != null) {
      widget.onDelete!(initialPage);
      setState(() {
        if (initialPage > 0 && imgs!.length < initialPage) {
          initialPage = imgs!.length;
        }
      });
      if (imgs!.isEmpty) {
        CommonNavigates.goBack(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0.0,
        actions: [
          if (widget.onDelete != null)
            IconButton(onPressed: onDelete, icon: Icon(AppIcons.delete))
        ],
        title: Text("($initialPage/${imgs!.length}) ${widget.title ?? "image".tr}"),
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          String img = widget.imgs[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: RxImageProvider(img),
          );
        },
        itemCount: widget.imgs.length,
        pageController: PageController(initialPage: widget.initialPage),
        onPageChanged: (index) => {
          setState(() {
            initialPage = index;
          })
        },
      ),
    );
  }
}
