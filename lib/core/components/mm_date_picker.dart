import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/components/mm_input.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MMDatePicker extends StatefulWidget {
  final String? value;
  final String? labelText;
  final String? hintText;
  final dynamic Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String newPattern;
  const MMDatePicker(this.value,
      {super.key,
      this.labelText,
      this.hintText,
      this.onChanged,
      this.validator,
      this.newPattern = "dd/MM/yyyy"});

  @override
  State<MMDatePicker> createState() => _MMDatePickerState();
}

class _MMDatePickerState extends State<MMDatePicker> {
  String value = "";
  @override
  void initState() {
    setState(() {
      value = widget.value != null
          ? CommonMethods.formatDateTime(
              CommonMethods.convertToDateTime(widget.value!),
              newPattern: widget.newPattern)
          : "";
    });
    super.initState();
  }

  showDatePicker() {
    DatePicker.showDatePicker(context,
        currentTime: CommonMethods.convertToDateTime(widget.value!, valuedefault: DateTime.now()),
        showTitleActions: true, onChanged: (date) {
      setState(() {
        value = CommonMethods.formatDateTime(date, newPattern: widget.newPattern);
      });
      if (widget.onChanged != null) {
        widget.onChanged!(date.toIso8601String());
      }
    },
        onConfirm: (date) {},
        locale:
            Get.locale!.languageCode == "en" ? LocaleType.en : LocaleType.vi);
  }

  @override
  Widget build(BuildContext context) {
    return MMInput(value,
        readOnly: true,
        labelText: widget.labelText,
        hintText: widget.hintText ?? "choose".tr,
        style: const TextStyle(fontSize: 16),
        suffixIcon: IconButton(
          icon: const Icon(AppIcons.calendar_full),
          onPressed: showDatePicker,
        ),
        validator: widget.validator,
        onTap: showDatePicker);
  }
}
