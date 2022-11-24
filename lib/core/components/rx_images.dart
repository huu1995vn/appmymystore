// ignore_for_file: empty_catches, unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mymystore/core/components/part.dart';
import 'package:mymystore/core/components/rx_image.dart';
import 'package:mymystore/core/utilities/extensions.dart';
import 'package:mymystore/core/utilities/size_config.dart';
import 'package:skeletons/skeletons.dart';

class MMImages extends StatefulWidget {
  final List<String> data;
  final void Function(int)? onTap;
  const MMImages({super.key, required this.data, this.onTap});
  @override
  State<MMImages> createState() => _MMImagesState();
}

class _MMImagesState extends State<MMImages>
    with AutomaticKeepAliveClientMixin<MMImages> {
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
      data = widget.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.data == null && widget.data.isNotEmpty) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SkeletonLine(
            style: SkeletonLineStyle(
                height: 16, width: 64, borderRadius: BorderRadius.circular(8)),
          ));
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
        return GestureDetector(
            onTap: () => {
                  if (widget.onTap != null) {widget.onTap!(index)}
                },
            child: Stack(children: <Widget>[
              MMImage(widget.data[index]),
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    '',
                    style: const TextStyle().bold,
                  ),
                ),
              ),
            ]));
      },
    ).toList();
  }
}
