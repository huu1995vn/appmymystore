// ignore_for_file: empty_catches, unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_image.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class RxImages extends StatefulWidget {
  final List<String> data;
  const RxImages({super.key, required this.data});
  @override
  State<RxImages> createState() => _RxImagesState();
}

class _RxImagesState extends State<RxImages>
    with AutomaticKeepAliveClientMixin<RxImages> {
  @override
  bool get wantKeepAlive => true;
  int _current = 0;
  List<String> data = [];
  @override
  initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadData() {
    setState(() {
      data = widget.data ?? [IMAGE_NOT_FOUND];
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.data == null && widget.data.isNotEmpty) {
      return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RxCardSkeleton());
    } else {
      return Stack(children: [
            CarouselSlider(
                items: _items(),
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  aspectRatio: 1.5,
                  onPageChanged: (index, carouselPageChangedReason) {
                    if (!mounted) return;
                    setState(() {
                      _current = index;
                    });
                  },
                )),
            Positioned(
                bottom: 0.0,
                left: 0.0,
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(
                      widget.data,
                      (index, url) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? const Color.fromRGBO(0, 0, 0, 0.9)
                                  : const Color.fromRGBO(0, 0, 0, 0.4)),
                        );
                      },
                    ),
                  ),
                )),
          ]);
    }
  }

  List<Widget> _items() {
    return map<Widget>(
      widget.data,
      (index, i) {
        return Stack(children: <Widget>[
          RxImage(widget.data[index]),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '',
                style: const TextStyle().bold,
              ),
            ),
          ),
        ]);
      },
    ).toList();
  }
}
