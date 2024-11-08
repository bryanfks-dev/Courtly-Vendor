import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/domain/entities/page_props.dart';
import 'package:courtly_vendor/presentation/pages/home.dart';
import 'package:courtly_vendor/presentation/pages/orders.dart';
import 'package:courtly_vendor/presentation/pages/reviews.dart';
import 'package:courtly_vendor/presentation/pages/vendor_profile.dart';
import 'package:courtly_vendor/presentation/widgets/bottom_navbar.dart';
import 'package:courtly_vendor/presentation/widgets/centered_app_bar.dart';
import 'package:courtly_vendor/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [AppScaffold] is the main application scaffold widget.
/// This widget is the root of the application.
class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
  });

  @override
  State<AppScaffold> createState() => _AppScaffold();
}

class _AppScaffold extends State<AppScaffold> {
  /// [_selectedIndex] is the index of the selected page
  /// from bottom navigation bar.
  int _selectedIndex = 0;

  /// [pages] is the list of pages that can be selected from
  /// bottom navigation bar.
  final List<PageProps> pages = [
    PageProps(
        appBar: const DefaultAppBar(),
        body: const HomePage(),
        icon: const HeroIcon(HeroIcons.home),
        selectedIcon:
            const HeroIcon(HeroIcons.home, style: HeroIconStyle.solid),
        label: "Home",
        backgroundColor: ColorSchemes.secondaryBackground),
    PageProps(
        appBar: const CenteredAppBar(title: "Orders"),
        body: const OrdersPage(),
        icon: const HeroIcon(HeroIcons.clipboardDocumentList),
        selectedIcon: const HeroIcon(HeroIcons.clipboardDocumentList,
            style: HeroIconStyle.solid),
        label: "Orders",
        backgroundColor: ColorSchemes.secondaryBackground),
    PageProps(
        appBar: const CenteredAppBar(title: "Reviews"),
        body: const ReviewsPage(),
        icon: const HeroIcon(HeroIcons.chatBubbleLeftEllipsis),
        selectedIcon: const HeroIcon(HeroIcons.chatBubbleLeftEllipsis,
            style: HeroIconStyle.solid),
        label: "Reviews",
        backgroundColor: ColorSchemes.secondaryBackground),
    PageProps(
        appBar: const CenteredAppBar(title: "Vendor Profile"),
        body: const VendorProfilePage(),
        icon: const HeroIcon(HeroIcons.briefcase),
        selectedIcon:
            const HeroIcon(HeroIcons.briefcase, style: HeroIconStyle.solid),
        label: "Vendor Profile",
        backgroundColor: ColorSchemes.secondaryBackground)
  ];

  /// [_changePage] is a function to change page using bottom navigation bar.
  /// It takes [newIndex] as the index of the new page.
  ///
  /// - Parameters:
  ///   - [newIndex]: The index of the new page.
  ///
  /// - Returns: void
  void _changePage(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: pages[_selectedIndex].appBar,
      body: pages[_selectedIndex].body,
      backgroundColor: pages[_selectedIndex].backgroundColor,
      bottomNavigationBar: BottomNavbar(
          pages: pages, selectedIndex: _selectedIndex, changePage: _changePage),
    );
  }
}
