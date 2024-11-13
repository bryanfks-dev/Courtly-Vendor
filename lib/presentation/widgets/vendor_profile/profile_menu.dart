import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [ProfileMenu] is a menu item in the profile page.
class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {super.key,
      required this.iconData,
      required this.title,
      required this.onTap});

  /// [iconData] is the icon of the menu.
  final HeroIcons iconData;

  /// [title] is the title of the menu.
  final String title;

  /// [onTap] is the function to be called when the menu is tapped.
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorSchemes.primaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HeroIcon(iconData, color: ColorSchemes.highlight, size: 20),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(title,
                      style: TextStyle(fontSize: 14, color: ColorSchemes.text))
                ],
              ),
              HeroIcon(
                HeroIcons.chevronRight,
                color: ColorSchemes.highlight,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
