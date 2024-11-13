import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:flutter/material.dart';

/// [OrderCard] is a widget that displays a card
/// containing order information.
/// 
/// It is used in the [OrdersPage] widget.
class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: PAGE_PADDING_MOBILE),
        decoration: BoxDecoration(color: ColorSchemes.primaryBackground),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sept 3, 2024",
                    style: TextStyle(
                        color: ColorSchemes.highlight,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
                Text("13:00 - 15:00",
                    style: TextStyle(
                        color: ColorSchemes.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ],
            ),
            const SizedBox(height: 3),
            Text("Joko Wkwk",
                style: TextStyle(
                    color: ColorSchemes.text,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis)),
            Text("Badminton Court",
                style: TextStyle(color: ColorSchemes.text, fontSize: 14)),
            const SizedBox(height: 3),
            Text("BCA - Rp 30,000",
                style: TextStyle(
                    color: ColorSchemes.text,
                    fontWeight: FontWeight.w700,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
