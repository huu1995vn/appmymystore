import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class CarsHighlightWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 20,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 200,
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "toyota-viet-nam",
                      child: Container(
                        height: 140,
                        width: 180,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://cdn.dailyxe.com.vn/image/toyota-viet-nam-33547j22.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "Tiêu đề",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Mô tả",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7, top: 5, right: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '400.000.000',
                            style:
                                TextStyle(color: AppColors.red, fontSize: 12),
                          ),
                          Row(
                            children: const [
                              Text(
                                "4*",
                                style: TextStyle(color: AppColors.yellow),
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.yellow,
                                size: 12,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
