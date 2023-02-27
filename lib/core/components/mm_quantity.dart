// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_null_comparison, non_constant_identifier_names, empty_catches

import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';

class MMQuantity extends StatefulWidget {
  final dynamic data;
  final dynamic Function(int)? onChange;

  const MMQuantity(this.data, {super.key, this.onChange});
  @override
  MMQuantityState createState() => MMQuantityState();
}

class MMQuantityState extends State<MMQuantity> {
  int _quantity = 0;

  @override
  MMQuantityState();
  @override
  initState() {
    super.initState();
    setState(() {
      _quantity = widget.data;
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  onchange(pQuantity) {
    setState(() => _quantity = pQuantity);
    if (widget.onChange != null) {
      widget.onChange!(_quantity);
    }
  }

  @override
  Widget build(context) {
    return Row(
      children: [
        const Text('Quantity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: Color(0xFFF3F3F3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: const Icon(AppIcons.circle_minus),
                  onTap: () {
                    if (_quantity <= 0) return;
                    onchange(_quantity - 1);
                  },
                ),
                const SizedBox(width: 20),
                Text('$_quantity',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                const SizedBox(width: 20),
                InkWell(
                  child: const Icon(AppIcons.plus_circle),
                  onTap: () => {onchange(_quantity + 1)},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
