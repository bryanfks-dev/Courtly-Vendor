import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:flutter/material.dart';

/// [RecentOrderCard] is a widget that displays a card
/// containing recent order information.
class RecentOrderCard extends StatelessWidget {
  const RecentOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: ColorSchemes.subtle),
          borderRadius: BorderRadius.circular(20),
        ),
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
            Text("Rp 30,000",
                style: TextStyle(
                    color: ColorSchemes.text,
                    fontWeight: FontWeight.w500,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
