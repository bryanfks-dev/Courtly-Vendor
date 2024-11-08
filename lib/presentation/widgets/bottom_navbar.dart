import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/domain/entities/page_props.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar(
      {super.key,
      required this.pages,
      required this.selectedIndex,
      required this.changePage});

  /// [pages] is the list of pages that can be selected from
  final List<PageProps> pages;

  /// [selectedIndex] is the selected index of the page
  final int selectedIndex;

  /// [changePage] is a function to change page using bottom navigation bar.
  final void Function(int) changePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(
          top: BorderSide(
            color: ColorSchemes.subtle,
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorSchemes.primaryBackground,
          currentIndex: selectedIndex,
          items: [
            for (int i = 0; i < pages.length; i++) ...[
              BottomNavigationBarItem(
                  icon: (selectedIndex == i)
                      ? (pages[i].selectedIcon ?? pages[i].icon)
                      : pages[i].icon,
                  label: pages[i].label),
            ]
          ],
          iconSize: 24,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: (int newIndex) {
            if (selectedIndex == newIndex) {
              return;
            }

            // Change the page.
            changePage(newIndex);
          },
        ),
      ),
    );
  }
}
