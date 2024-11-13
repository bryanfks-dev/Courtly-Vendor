import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:flutter/material.dart';

/// [ProfileMenuCard] is a card that contains a list of profile menu items.
class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    required this.title,
    required this.menus,
  });

  /// [title] is the title of the profile menu card.
  final String title;

  /// [menus] is a list of profile menu items.
  final List<Widget> menus;

  @override
  Widget build(BuildContext context) {
    /// [menuLength] is the length of the menu items.
    final menuLength = menus.length;

    return Container(
      color: ColorSchemes.primaryBackground,
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: ColorSchemes.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Column(
            children: [
              for (int i = 0; i < menuLength; i++) ...[
                menus[i],
                if (i < menuLength - 1)
                  Divider(
                    color: ColorSchemes.subtle,
                    indent: PAGE_PADDING_MOBILE * 3,
                    height: 0,
                  ),
              ],
            ],
          )
        ],
      ),
    );
  }
}
