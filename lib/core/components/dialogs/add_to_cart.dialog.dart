import 'package:flutter/material.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

class AddToCartModal extends StatefulWidget {
  @override
  _AddToCartModalState createState() => _AddToCartModalState();
}

class _AddToCartModalState extends State<AddToCartModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // ----------
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 6,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.primarySoft,
            ),
          ),
          // Section 1 - increment button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 6),
                child: Text(
                  'Jumlah Produk',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    color: const Color(0xFF0A0E2F).withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.remove, size: 20, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primary, shape: const CircleBorder(), backgroundColor: AppColors.grey,
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      '2',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'poppins'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.add, size: 20, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primary, shape: const CircleBorder(), backgroundColor: AppColors.grey,
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                ],
              )
            ],
          ),
          // Section 2 - Total and add to cart button
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(4),
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.primarySoft,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('TOTAL', style: TextStyle(fontSize: 10, fontFamily: 'poppins')),
                        const Text('Rp 1,429,000', style: TextStyle(fontSize: 16, fontFamily: 'poppins', fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
                    },
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'poppins'),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}