// ignore_for_file: curly_braces_in_flow_control_structures, must_call_super, empty_catches, library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

class MMInput extends StatefulWidget {
  final String? value;
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
  final List<TextInputFormatter>? inputFormatters;
  const MMInput(this.value,
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
      this.minLines,
      this.inputFormatters});

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<MMInput> {
  TextEditingController input = TextEditingController();
  bool showPassword = false;
  var _focusNode = new FocusNode();

  _focusListener() {
    setState(() {});
  }

  @override
  void initState() {
    _focusNode.addListener(_focusListener);

    super.initState();
    if (mounted && widget.value != input.text) input.text = widget.value ?? "";
  }

  @override
  void didUpdateWidget(MMInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      Future.delayed(Duration.zero, () {
        if (mounted && widget.value != input.text) input.text = widget.value!;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);

    super.dispose();
    input.dispose();
  }

  @override
  Widget build(context) {
    InputBorder inputborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(CommonConstants.kDefaultRadius),
      borderSide: BorderSide(color: Theme.of(context).cardColor, width: 1),
    );
    return MMListTile(
        title: widget.labelText == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(CommonConstants.kDefaultPadding)
                    .copyWith(left: 0, top: 0),
                child: RichText(
                  text: TextSpan(
                    // text: lableText ?? type.tr(),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.labelText,
                          style: CommonConstants.kTextTitleStyle.copyWith(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .color)),
                      if (widget.validator != null)
                        const TextSpan(
                            text: ' *',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.error)),
                    ],
                  ),
                ),
              ),
        subtitle: TextFormField(
            onTap: widget.onTap,
            focusNode: _focusNode,
            readOnly: widget.readOnly || widget.disabled,
            controller: input,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters ??
                (widget.keyboardType == TextInputType.number
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ]
                    : null),
            obscureText: !showPassword && widget.isPassword,
            maxLength: widget.maxLength,
            minLines: widget.isPassword ? 1 : widget.minLines,
            maxLines: widget.isPassword
                ? 1
                : (widget.minLines != null ? widget.minLines! + 5 : null),
            maxLengthEnforcement: widget.maxLengthEnforcement,
            validator: widget.validator,
            onChanged: widget.onChanged,
            style: widget.style,
            decoration: InputDecoration(
                errorStyle: const TextStyle(height: 0.6),
                isDense: true,
                fillColor: Theme.of(context).cardColor,
                filled: true,
                border: inputborder,
                enabledBorder: inputborder,
                focusedBorder: inputborder,
                errorBorder: inputborder,
                // labelText: widget.labelText,
                hintText: widget.hintText ??
                    "${"enter".tr} ${widget.labelText ?? "".toLowerCase()}",
                prefixIcon: widget.icon != null
                    ? IconButton(
                        icon: widget.icon!,
                        onPressed: () {},
                      )
                    : null,
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
                    : widget.suffixIcon)));
  }
}

class ThousandsFormatter extends NumberInputFormatter {
  static final NumberFormat _formatter = NumberFormat.decimalPattern();

  final FilteringTextInputFormatter _decimalFormatter;
  final String _decimalSeparator;
  final RegExp _decimalRegex;

  final NumberFormat? formatter;
  final bool allowFraction;

  ThousandsFormatter({this.formatter, this.allowFraction = false})
      : _decimalSeparator = (formatter ?? _formatter).symbols.DECIMAL_SEP,
        _decimalRegex = RegExp(allowFraction
            ? '[0-9]+([${(formatter ?? _formatter).symbols.DECIMAL_SEP}])?'
            : r'\d+'),
        _decimalFormatter = FilteringTextInputFormatter.allow(RegExp(
            allowFraction
                ? '[0-9]+([${(formatter ?? _formatter).symbols.DECIMAL_SEP}])?'
                : r'\d+'));

  @override
  String _formatPattern(String? digits) {
    if (digits == null || digits.isEmpty) return '';
    num number;
    if (allowFraction) {
      String decimalDigits = digits;
      if (_decimalSeparator != '.') {
        decimalDigits = digits.replaceFirst(RegExp(_decimalSeparator), '.');
      }
      number = double.tryParse(decimalDigits) ?? 0.0;
    } else {
      number = int.tryParse(digits) ?? 0;
    }
    final result = (formatter ?? _formatter).format(number);
    if (allowFraction && digits.endsWith(_decimalSeparator)) {
      return '$result$_decimalSeparator';
    }
    return result;
  }

  @override
  TextEditingValue _formatValue(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return _decimalFormatter.formatEditUpdate(oldValue, newValue);
  }

  @override
  bool _isUserInput(String s) {
    return s == _decimalSeparator || _decimalRegex.firstMatch(s) != null;
  }
}

///
/// An implementation of [NumberInputFormatter] that converts a numeric input
/// to credit card number form (4-digit grouping). For example, a input of
/// `12345678` should be formatted to `1234 5678`.
///
class CreditCardFormatter extends NumberInputFormatter {
  static final RegExp _digitOnlyRegex = RegExp(r'\d+');
  static final FilteringTextInputFormatter _digitOnlyFormatter =
      FilteringTextInputFormatter.allow(_digitOnlyRegex);

  final String separator;

  CreditCardFormatter({this.separator = ' '});

  @override
  String _formatPattern(String digits) {
    StringBuffer buffer = StringBuffer();
    int offset = 0;
    int count = min(4, digits.length);
    final length = digits.length;
    for (; count <= length; count += min(4, max(1, length - count))) {
      buffer.write(digits.substring(offset, count));
      if (count < length) {
        buffer.write(separator);
      }
      offset = count;
    }
    return buffer.toString();
  }

  @override
  TextEditingValue _formatValue(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return _digitOnlyFormatter.formatEditUpdate(oldValue, newValue);
  }

  @override
  bool _isUserInput(String s) {
    return _digitOnlyRegex.firstMatch(s) != null;
  }
}

///
/// An abstract class extends from [TextInputFormatter] and does numeric filter.
/// It has an abstract method `_format()` that lets its children override it to
/// format input displayed on [TextField]
///
abstract class NumberInputFormatter extends TextInputFormatter {
  TextEditingValue? _lastNewValue;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    /// nothing changes, nothing to do
    if (newValue.text == _lastNewValue?.text) {
      return newValue;
    }
    _lastNewValue = newValue;

    /// remove all invalid characters
    newValue = _formatValue(oldValue, newValue);

    /// current selection
    int selectionIndex = newValue.selection.end;

    /// format original string, this step would add some separator
    /// characters to original string
    final newText = _formatPattern(newValue.text);

    /// count number of inserted character in new string
    int insertCount = 0;

    /// count number of original input character in new string
    int inputCount = 0;
    for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
      final character = newText[i];
      if (_isUserInput(character)) {
        inputCount++;
      } else {
        insertCount++;
      }
    }

    /// adjust selection according to number of inserted characters staying before
    /// selection
    selectionIndex += insertCount;
    selectionIndex = min(selectionIndex, newText.length);

    /// if selection is right after an inserted character, it should be moved
    /// backward, this adjustment prevents an issue that user cannot delete
    /// characters when cursor stands right after inserted characters
    if (selectionIndex - 1 >= 0 &&
        selectionIndex - 1 < newText.length &&
        !_isUserInput(newText[selectionIndex - 1])) {
      selectionIndex--;
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: selectionIndex),
        composing: TextRange.empty);
  }

  /// check character from user input or being inserted by pattern formatter
  bool _isUserInput(String s);

  /// format user input with pattern formatter
  String _formatPattern(String digits);

  /// validate user input
  TextEditingValue _formatValue(
      TextEditingValue oldValue, TextEditingValue newValue);
}
