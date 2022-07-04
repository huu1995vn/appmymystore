// ignore_for_file: empty_catches

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_image.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ListBannerWidget extends StatefulWidget {
  const ListBannerWidget({super.key});
  @override
  State<ListBannerWidget> createState() => _ListBannerWidgetState();
}

class _ListBannerWidgetState extends State<ListBannerWidget>
    with AutomaticKeepAliveClientMixin<ListBannerWidget> {
  @override
  bool get wantKeepAlive => true;
  int _current = 0;
  static List<String> data = [
    'https://stgcdndlxad02.dailyxe.com.vn/image/banner-raoxe-99059j.jpg',
    'https://stgcdndlxad02.dailyxe.com.vn/image/banner-raoxe-99059j.jpg',
    'https://stgcdndlxad02.dailyxe.com.vn/image/banner-raoxe-99059j.jpg',
    'https://stgcdndlxad02.dailyxe.com.vn/image/banner-raoxe-99059j.jpg',
  ];
  // List<String> data;
  // StreamSubscription sup;
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
   
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return data == null
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RxCardSkeleton())
        : Stack(children: [
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
                      data,
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

  List<Widget> _items() {
    return map<Widget>(
      data,
      (index, i) {
        return Container(
          margin: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            child: Stack(children: <Widget>[
              RxImage(data[index]),
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
            ]),
          ),
        );
      },
    ).toList();
  }
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  if(list==null) return result;
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}
