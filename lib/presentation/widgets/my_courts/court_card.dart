import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CourtCard extends StatelessWidget {
  const CourtCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(
              color: ColorSchemes.subtle,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Basketball Court",
                  style: TextStyle(
                      color: ColorSchemes.text,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Total: ${3} Court(s)",
                  style: TextStyle(color: ColorSchemes.text, fontSize: 10),
                )
              ],
            )),
            IconButton(
                onPressed: () {},
                icon: HeroIcon(
                  HeroIcons.trash,
                  color: ColorSchemes.error,
                  size: 20,
                ))
          ],
        ),
      ),
    );
  }
}
