import 'dart:math';

import 'package:flutter/material.dart';

class CarsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: ListView.separated(
          separatorBuilder: (_, index) => const SizedBox(
                height: 10,
              ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 8.0)
                      ]),
                  child: Stack(
                    children: [
                      Positioned(
                          child: Hero(
                        tag: "image",
                        child: Container(
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            image: DecorationImage(
                                image: const NetworkImage(
                                    "https://cdn.dailyxe.com.vn/image/toyota-viet-nam-33547j22.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      )),
                      Positioned(
                          top: 15,
                          right: 110,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tiêu đề",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Mô tả",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '400.000',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.directions_car,
                                      color: Colors.red,
                                    ),
                                    const Icon(
                                      Icons.hot_tub,
                                      color: Colors.red,
                                    ),
                                    const Icon(
                                      Icons.local_bar,
                                      color: Colors.red,
                                    ),
                                    const Icon(
                                      Icons.wifi,
                                      color: Colors.red,
                                    ),
                                    const Icon(
                                      Icons.park,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      Positioned(
                          bottom: 40,
                          left: 300,
                          child: Center(
                            child: Transform.rotate(
                              angle: pi / -2,
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                child: const Center(child: Text('BOOK NOW')),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
