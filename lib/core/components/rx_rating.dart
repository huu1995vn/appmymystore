import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class RxReview extends StatefulWidget {
  const RxReview(this.item, {Key? key}) : super(key: key);
  final ProductModel item;

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<RxReview> {
  int displayPage = 1;
  bool loading = false;
  List<ProductReviewsModel> data = [];
  int userId = APITokenService.userId;
  @override
  initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      Map<String, dynamic> body = {
        "productid": widget.item.id,
        "p": 1,
        "n": 2
      };
      var res = await DaiLyXeApiBLL_APIGets().ratinglist(body);
      if (res.status > 0) {
        
        if (!mounted) return;
        setState(() {
          data = res.data; // Chỉ lấy 2 phần tử đầu.
        });
      }
    } catch (e) {
      // CommonMethods.showDialogError(context, e.toString());
    }
  }

  onDialogRating(context) async {
    
  }

  viewAll() {
    // CommonNavigates.openDialog(
    //     context,
    //     DialogRatingList(
    //       item: widget.item,
    //     ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double ratingvalue = double.parse(widget.item.ratingvalue ?? "0.0");
    double review1 = double.parse(widget.item.review1 ?? "0.0");
    double review2 = double.parse(widget.item.review2 ?? "0.0");
    double review3 = double.parse(widget.item.review3 ?? "0.0");
    double review4 = double.parse(widget.item.review4 ?? "0.0");
    double review5 = double.parse(widget.item.review5 ?? "0.0");

    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "$ratingvalue/5",
                  ),
                  RatingBar.builder(
                    initialRating: ratingvalue,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    allowHalfRating: true,
                    onRatingUpdate: (_) {},
                  ),
                  Text(
                    '(${widget.item.reviewcount ?? 0} nhận xét)',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildRating(context, 1,
                      ratingvalue == 0.0 ? 0.0 : (review1 / ratingvalue)),
                  _buildRating(context, 2,
                      ratingvalue == 0.0 ? 0.0 : (review2 / ratingvalue)),
                  _buildRating(context, 3,
                      ratingvalue == 0.0 ? 0.0 : (review3 / ratingvalue)),
                  _buildRating(context, 4,
                      ratingvalue == 0.0 ? 0.0 : (review4 / ratingvalue)),
                  _buildRating(context, 5,
                      ratingvalue == 0.0 ? 0.0 : (review5 / ratingvalue)),
                ],
              ),
            ],
          ),
         
          GestureDetector(
            onTap: () {
              if (!CommonMethods.isLogin()) {
                CommonMethods.showToast("Vui lòng đăng nhập trước");
              } else {
                onDialogRating(context);
              }
            },
            child: Container(
                color: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  "writerreview".tr().toUpperCase(),
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                )),
          ),
          RxListView(data, _listItem,
              key: Key("writerreview".tr()),
              onRefresh: loadData,
              padding: EdgeInsets.zero,
              noFound: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text("not.evaluate".tr()))),
          if (data != null && data!.length >= 2)
            GestureDetector(
              onTap: () {
                viewAll();
              },
              child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Xem tất cả",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.blue,
                      )
                    ],
                  )),
            )
        ]));
  }

  Widget _listItem(BuildContext context, int index) {
    ProductReviewsModel item = data![index];
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1,
                    color: index != 0 ? Colors.black12 : Colors.transparent))),
        child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RatingBar.builder(
                initialRating: double.parse(item.ratingvalue ?? "0.0"),
                itemSize: 15.0,
                minRating: 0,
                direction: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (_) {},
              ),
              // Container(
              //   margin: const EdgeInsets.only(bottom: 3, top: 0),
              //   child: Text(CommonMethods.timeagoFormat(item.NgayCapNhat)),
              // ),
            ],
          ),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child:
                      Text(item.username ?? "", style: const TextStyle().bold),
                ),
                TextFormField(
                  initialValue: item.comment,
                  minLines:
                      6, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ]),
        ));
  }

  Widget _buildRating(BuildContext context, double rating, double value) {
    return Row(children: <Widget>[
      RatingBar.builder(
        initialRating: rating,
        itemSize: 15.0,
        ignoreGestures: false,
        minRating: 0,
        direction: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (_) {},
      ),
      Container(
        width: 60,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: LinearProgressIndicator(
          backgroundColor: Colors.green[100],
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.success.withOpacity(0.8),
          ),
          value: (value * 100) / 100,
        ),
      ),
      SizedBox(
          width: 50.0,
          child: Text(
            '${(value * 100).toStringAsFixed(2)}%',
          ))
    ]);
  }
}
