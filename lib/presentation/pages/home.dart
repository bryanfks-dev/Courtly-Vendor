import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/widgets/home/recent_order_card.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [HomePage] is the home page widget.
/// This widget is the first page of the application.
/// It contains the summary of the recent orders and other details.
class HomePage extends StatelessWidget {
  HomePage({super.key, required this.changePageCallback});

  /// [changePageCallback] is the callback function to change the page.
  final ValueChanged<int> changePageCallback;

  /// [_recentOrders] is the list of recent orders.
  final ValueNotifier<List<dynamic>> _recentOrders = ValueNotifier([1, 2, 3]);

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
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent Orders",
                    style: TextStyle(
                        color: ColorSchemes.text,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    changePageCallback(1);
                  },
                  child: Text("View All",
                      style:
                          TextStyle(color: ColorSchemes.primary, fontSize: 12)),
                )
              ],
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
                valueListenable: _recentOrders,
                builder: (BuildContext context, value, _) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, _) =>
                          const RecentOrderCard(),
                      separatorBuilder: (BuildContext context, _) =>
                          const SizedBox(height: 10),
                      itemCount: value.length);
                }),
            const SizedBox(height: PAGE_PADDING_MOBILE),
          ],
        ),
      ),
    );
  }
}
