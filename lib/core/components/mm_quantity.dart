// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_null_comparison, non_constant_identifier_names, empty_catches

import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/utilities/size_config.dart';

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

  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: SizeConfig.getProportionateScreenWidth(258),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: const Color(0xFF101010),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
                  const SizedBox(width: 16),
                  const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(height: 1, color: const Color(0xFFEEEEEE)),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Total price',
                        style:
                            TextStyle(color: Color(0xFF757575), fontSize: 12)),
                    SizedBox(height: 6),
                    Text('\$280.00',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ],
                ),
                buildAddCard()
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
