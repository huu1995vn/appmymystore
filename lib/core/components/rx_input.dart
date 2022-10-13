// ignore_for_file: curly_braces_in_flow_control_structures, must_call_super, empty_catches, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class RxInput extends StatefulWidget {
  final String value;
  final String? labelText;
  final String? hintText;
  final bool disabled;
  final Widget? icon;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final bool isBorder;
  final void Function()? onTap;
  final TextStyle? style;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLength;
  final int? minLines;
  const RxInput(this.value,
      {super.key,
      this.disabled = false,
      this.validator,
      this.labelText,
      this.hintText,
      this.icon,
      this.readOnly = false,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.onChanged,
      this.suffixIcon,
      this.isBorder = false,
      this.onTap,
      this.style,
      this.maxLengthEnforcement,
      this.maxLength,
      this.minLines});

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<RxInput> {
  TextEditingController input = TextEditingController();
  bool showPassword = false;
  @override
  void initState() {
    super.initState();
    if (mounted && widget.value != input.text) input.text = widget.value ?? "";
  }

  @override
  void didUpdateWidget(RxInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      Future.delayed(Duration.zero, () {
        if (mounted && widget.value != input.text)
          input.text = widget.value ?? "";
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    input.dispose();
  }

  @override
  Widget build(context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly || widget.disabled,
      controller: input,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.keyboardType == TextInputType.number
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      obscureText: !showPassword && widget.isPassword,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.minLines!=null ? widget.minLines! +  5: null,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: widget.style,
      decoration: InputDecoration(
          isDense: true,
          fillColor: widget.isBorder ? Theme.of(context).cardTheme.color : null,
          filled: widget.isBorder,
          border: widget.isBorder == true
              ? const OutlineInputBorder()
              : InputBorder.none,
          labelText: widget.labelText,
          hintText: widget.hintText,
          icon: widget.icon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(showPassword == true
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : widget.suffixIcon),
    );
  }
}
