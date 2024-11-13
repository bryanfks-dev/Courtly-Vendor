import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:heroicons/heroicons.dart';

/// [ProfileMenuToggle] is a menu item in the profile page.
class ProfileMenuToggle extends StatelessWidget {
  const ProfileMenuToggle(
      {super.key,
      required this.iconData,
      required this.title,
      this.defaultValue = false,
      required this.onChanged});

  /// [iconData] is the icon of the menu.
  final HeroIcons iconData;

  /// [title] is the title of the menu.
  final String title;

  /// [defaultValue] is the default value of the toggle.
  final bool defaultValue;

  /// [onChanged] is the function to be called when the menu is tapped.
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorSchemes.primaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
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
                    style: TextStyle(fontSize: 14, color: ColorSchemes.text)),
              ],
            ),
            Transform.scale(
              scale: 0.75,
              child: CupertinoSwitch(
                value: defaultValue,
                onChanged: (bool value) {
                  onChanged(value);
                },
                activeColor: ColorSchemes.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
