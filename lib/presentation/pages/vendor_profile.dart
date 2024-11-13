import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/widgets/vendor_profile/profile_menu.dart';
import 'package:courtly_vendor/presentation/widgets/vendor_profile/profile_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class VendorProfilePage extends StatelessWidget {
  const VendorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: PAGE_PADDING_MOBILE,
                  right: PAGE_PADDING_MOBILE,
                  bottom: 20),
              decoration: BoxDecoration(color: ColorSchemes.primaryBackground),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Unggul Sport Centre",
                        style: TextStyle(
                            color: ColorSchemes.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              color: ColorSchemes.primary,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorSchemes.primary),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                            color: ColorSchemes.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      const SizedBox(height: 3),
                      Text(
                          "Jl. Belimbing Indah No. 29, Pakis, Tirtomoyo, Kab. Malang, Jawa Timur",
                          style:
                              TextStyle(color: ColorSchemes.text, fontSize: 14))
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Operational Hours",
                        style: TextStyle(
                            color: ColorSchemes.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      const SizedBox(height: 3),
                      Text("09:00 - 23:00",
                          style:
                              TextStyle(color: ColorSchemes.text, fontSize: 14))
                    ],
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                      overlayColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                      onTap: () {},
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("View Your Courts",
                                style: TextStyle(
                                    color: ColorSchemes.text, fontSize: 14)),
                            HeroIcon(
                              HeroIcons.chevronRight,
                              size: 18,
                              color: ColorSchemes.highlight,
                            )
                          ]))
                ],
              ),
            ),
            const SizedBox(height: 10),
            ProfileMenuCard(title: "Account Settings", menus: [
              ProfileMenu(
                  iconData: HeroIcons.lockClosed,
                  title: "Change Password",
                  onTap: () {}),
            ]),
            const SizedBox(height: 10),
            ProfileMenu(
                iconData: HeroIcons.arrowRightOnRectangle,
                title: "Log Out",
                onTap: () {})
          ],
        ),
      ),
    );
  }
}
