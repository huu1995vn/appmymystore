// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class ActiveDot extends StatelessWidget {
  const ActiveDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class InactiveDot extends StatelessWidget {
  const InactiveDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class RxSlider extends StatefulWidget {
  final List items;
  final void Function(int)? onTap;
  const RxSlider({required this.items, Key? key, this.onTap}) : super(key: key);

  @override
  _RxSliderState createState() => _RxSliderState();
}

class _RxSliderState extends State<RxSlider> {
  int activeIndex = 0;

  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlayInterval: const Duration(seconds: 5),
            autoPlay: true,
            height: 270,
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setActiveDot(index);
            },
          ),
          items: List.generate(
            widget.items.length,
            (index) {
              return GestureDetector(
                  onTap: () => {
                        if (widget.onTap != null) {widget.onTap!(index)}
                      },
                  child: Container(
                    margin: const EdgeInsets.only(left: 0, right: 0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      // borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: RxImageProvider(widget.items[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ));
            },
          ),
        ),
        Positioned(
          bottom: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.items.length,
              (idx) {
                return activeIndex == idx
                    ? const ActiveDot()
                    : const InactiveDot();
              },
            ),
          ),
        ),
      ],
    );
  }
}
