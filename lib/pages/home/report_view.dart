import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

class ReportView extends StatelessWidget {
  const ReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(68.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppColors.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 48,
                              width: 2,
                              decoration: BoxDecoration(
                                color: const Color(0xFF87A0E5).withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Đang xử lý',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      // letterSpacing: -0.1,
                                    ),
                                  ),
                                  TextButton.icon(
                                      icon: const Icon(AppIcons.rocket_1,
                                          color: AppColors.warning),
                                      label: const Text("11111"),
                                      onPressed: () {})
                                ],
                              ),
                            )
                          ],
                        ),
                        
                        Row(
                          children: <Widget>[
                            Container(
                              height: 48,
                              width: 2,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF56E98).withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 4, bottom: 2),
                                    child: Text(
                                      'Hoàn thành',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        // fontFamily:
                                        //     WeatherAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                      ),
                                    ),
                                  ),
                                  TextButton.icon(
                                      icon: const Icon(
                                        AppIcons.checkmark_cicle,
                                        color: AppColors.success,
                                      ),
                                      label: const Text("11111"),
                                      onPressed: () {})
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.antiAlias,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                              border: Border.all(
                                  width: 4, color: AppColors.primary),
                            ),
                            child: const Icon(
                              AppIcons.account_balance,
                              size: 50,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Doanh thu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontFamily: WeatherAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: -0.2,
                          // color: AppColors.darkText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          height: 4,
                          width: 70,
                          decoration: BoxDecoration(
                            color: const Color(0xFF87A0E5).withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: (70 / 1.2),
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: <Color>[
                                    const Color(0xFF87A0E5),
                                    const Color(0xFF87A0E5).withOpacity(0.5),
                                  ]),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          "10000",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Đơn hàng',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // fontFamily: WeatherAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              // color: AppColors.darkText,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Container(
                              height: 4,
                              width: 70,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF56E98).withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (70 / 2),
                                    height: 4,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                        const Color(0xFFF56E98)
                                            .withOpacity(0.1),
                                        const Color(0xFFF56E98),
                                      ]),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              '1000',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // fontFamily: WeatherAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Lợi nhuận',
                            style: TextStyle(
                              // fontFamily: WeatherAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              // color: AppColors.darkText,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Container(
                              height: 4,
                              width: 70,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1B440).withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (70 / 2.5),
                                    height: 4,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                        const Color(0xFFF1B440)
                                            .withOpacity(0.1),
                                        const Color(0xFFF1B440),
                                      ]),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              'kmkm',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
