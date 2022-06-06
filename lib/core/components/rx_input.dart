// ignore_for_file: curly_braces_in_flow_control_structures, must_call_super, empty_catches, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/constants.dart';

class RxInput extends StatefulWidget {
  final dynamic value;
  final String? labelText;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool require;
  final Color? fillColor;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final bool readOnlyTransparent;
  final bool readOnly;
  final bool? lock;
  final Widget? icon;
  final Widget? suffixIconDefault;
  final InputBorder? border;
  final Widget? suffixIcon;
  final EdgeInsets? margin;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final InputBorder? focusedBorder;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  const RxInput(
    this.value, {
    this.onChanged,
    this.onTap,
    this.labelText,
    this.hintText,
    this.hintStyle,
    this.style,
    this.icon,
    this.validator,
    this.readOnly = false,
    this.readOnlyTransparent = false,
    this.margin,
    this.contentPadding,
    this.border,
    this.focusNode,
    this.fillColor,
    this.textInputAction,
    this.suffixIcon,
    this.require = false,
    this.focusedBorder,
    this.suffixIconDefault,
    this.onFieldSubmitted,
    this.keyboardType,
    this.lock,
    Key? key,
  }) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<RxInput> {
  TextEditingController input = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (mounted && widget.value != input.text)
      setState(() {
        input.text = widget.value;
      });
  }

  @override
  void dispose() {
    super.dispose();
    input.dispose();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    try {
      Future.delayed(Duration.zero, () {
        if (mounted && input.text != widget.value) {
          setState(() {
            input.text = widget.value;
          });
        }
      });
    } catch (e) {}
  }

  bool get lock {
    return widget.lock == null && widget.readOnly
        ? true
        : (widget.lock ?? false);
  }

  @override
  Widget build(context) {
    return RxDisabled(
        disabled: lock && widget.readOnly,
        lock: lock,
        child: TextFormField(
            // onTap: () {
            //   if (widget.onTap != null) widget.onTap!();
            // },
            // readOnly: widget.readOnly,
            controller: input,
            // style: widget.style ?? const TextStyle(color: Colors.black87),
            // textInputAction: widget.keyboardType != TextInputType.multiline
            //     ? widget.textInputAction ?? TextInputAction.done
            //     : null,
            // focusNode: widget.focusNode,
            // keyboardType: widget.keyboardType ?? TextInputType.text,
            // onChanged: (text) {
            //   widget.onChanged!(text);
            // },
            // onFieldSubmitted: (value) {
            //   widget.onFieldSubmitted!(value);
            // },
            decoration: InputDecoration(
              filled: true,
              // focusedBorder: widget.focusedBorder ?? FormStyle.focusedBorder,
              focusColor: Colors.white,
              fillColor: widget.fillColor,
              border: widget.border ?? FormStyle.border,
              errorBorder: FormStyle.errorBorder,
              focusedErrorBorder: FormStyle.errorBorder,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: widget.hintText,
              labelText: widget.labelText,
              prefixIcon: widget.icon,
              errorMaxLines: 2,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              // suffixIcon: widget.suffixIcon ??
              //     ((!lock && widget.keyboardType != TextInputType.multiline)
              //         ? GestureDetector(
              //             onTap: () {
              //               if (input.text.isNotEmpty) {
              //                 if (widget.onChanged != null) {
              //                   widget.onChanged!("");
              //                 }
              //                 input.text = "";
              //               }
              //             },
              //             child: (input.text.isEmpty || input.text == "")
              //                 ? widget.suffixIconDefault ?? Container()
              //                 : Icon(
              //                     Icons.clear,
              //                     color: Colors.grey[900],
              //                   ),
              //           )
              //         : null)
            ),
            validator: widget.validator));
  }
}
