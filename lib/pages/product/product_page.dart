// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/utilities/constants.dart';

class ProductPage extends StatefulWidget {
  Map<String, dynamic>? paramsSearch;
  ProductPage({super.key, this.paramsSearch});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    loadData(widget.paramsSearch);
  }

  loadData(Map<String, dynamic>? paramsSearch) {}
  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      appBar: AppBar(
        title: Text(
          'Tin đăng',
          style: kTextHeaderStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: RxWrapper(
        body: Column(
          children: const [Text("products")],
        ),
      ),
    );
  }
}
