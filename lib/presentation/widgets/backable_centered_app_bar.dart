import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/presentation/widgets/bottom_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [BackableCenteredAppBar] is a custom AppBar widget that is used as the AppBar
/// for the application that contains a centered title and back icon.
class BackableCenteredAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BackableCenteredAppBar(
      {super.key, required this.title, this.onBack, this.moreMenus})
      : preferredSize = const Size.fromHeight(56);

  @override

  /// [preferredSize] is the preferred size of the AppBar.
  final Size preferredSize;

  /// [onBack] is the callback function that is called when the back icon is
  /// clicked.
  final VoidCallback? onBack;

  /// [title] is the custom title of the AppBar.
  final String title;

  /// [moreMenus] is the list of more menus that will be shown when the more
  /// icon.
  final List<Widget>? moreMenus;

  /// [_showMoreModal] is a function that shows the more modal sheet.
  /// This function is used to show the more modal sheet when the more icon is
  /// clicked.
  ///
  /// - Parameters:
  /// - [context]: The [BuildContext] of the widget.
  ///
  /// Returns a [void].
  void _showMoreModal(BuildContext context) {
    showBottomModalSheet(
        context,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (int i = 0; i < moreMenus!.length; i++) ...[
            moreMenus![i],
            if (i != moreMenus!.length - 1) ...[
              const SizedBox(height: 5),
              Divider(
                thickness: 1,
                color: ColorSchemes.subtle,
              ),
              const SizedBox(height: 5),
            ]
          ],
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: HeroIcon(HeroIcons.chevronLeft,
              size: 20, color: ColorSchemes.highlight),
          onPressed: () {
            Navigator.of(context).pop();

            // Check if the onBack callback is not null.
            if (onBack != null) {
              onBack!();
            }
          },
        ),
        titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorSchemes.text),
        centerTitle: true,
        actions: (moreMenus != null)
            ? [
                IconButton(
                    onPressed: () => _showMoreModal(context),
                    icon: HeroIcon(
                      HeroIcons.ellipsisHorizontal,
                      size: 20,
                      color: ColorSchemes.highlight,
                    ))
              ]
            : null,
        title: Text(title));
  }
}
