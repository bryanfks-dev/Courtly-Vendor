import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
      child: SingleChildScrollView(
        physics: const PageScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                      color: ColorSchemes.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: ColorSchemes.primaryBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: HeroIcon(
                            HeroIcons.listBullet,
                            size: 20,
                            color: ColorSchemes.primary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "15",
                          style: TextStyle(
                              color: ColorSchemes.primaryBackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 28),
                        ),
                        Text(
                          "Total Orders",
                          style: TextStyle(
                              color: ColorSchemes.primaryBackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                      color: ColorSchemes.subtle,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: ColorSchemes.primaryBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: HeroIcon(
                            HeroIcons.clipboardDocumentList,
                            size: 20,
                            color: ColorSchemes.text,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "15",
                          style: TextStyle(
                              color: ColorSchemes.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 28),
                        ),
                        Text(
                          "Orders Today",
                          style: TextStyle(
                              color: ColorSchemes.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
