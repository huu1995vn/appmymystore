// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget RxDivider({double indent = 20}) {
  return Divider(
      thickness: 1, // thickness of the line
      indent: indent,
      endIndent: indent,
      height: 1);
}

Widget RxBuildItem(
    {required String title,
    Widget? icon,
    void Function()? onTap,
    Widget? trailing}) {
  return ListTile(
    leading: icon,
    title: Text(title),
    trailing: trailing,
    onTap: onTap,
  );
}

class RxDisabled extends StatelessWidget {
  final Widget child;
  final bool disabled;

  const RxDisabled({Key? key, this.disabled = false, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
        absorbing: disabled,
        child: AnimatedOpacity(
            opacity: disabled ? 0.5 : 1,
            duration: const Duration(milliseconds: 500),
            child: child));
  }
}

class RxWebView extends StatefulWidget {
  String url;
  String? title;

  RxWebView({super.key, required this.url, this.title});
  @override
  RxWebViewState createState() => RxWebViewState();
}

class RxWebViewState extends State<RxWebView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
        appBar: AppBar(
          title: Text(widget.title ?? ""),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
