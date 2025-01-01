import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/utils/money_formatter.dart';
import 'package:courtly_vendor/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// [RecentOrderCard] is a widget that displays a card
/// containing recent order information.
///
/// It is used in the [HomePage] widget.
class RecentOrderCard extends StatelessWidget {
  const RecentOrderCard({super.key, required this.order});

  /// [order] is an instance of [Order].
  final Order order;

  @override
  Widget build(BuildContext context) {
    /// [dateFormatter] is a date formatter object.
    final DateFormat dateFormatter = DateFormat("MMM d, yyyy");

    return InkWell(
      onTap: () {},
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: ColorSchemes.subtle),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.user.username,
                    style: TextStyle(
                        color: ColorSchemes.text,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis)),
                Text(dateFormatter.format(order.date),
                    style: TextStyle(
                        color: ColorSchemes.highlight,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ],
            ),
            Text("${order.courtType} Court",
                style: TextStyle(color: ColorSchemes.text, fontSize: 12)),
            const SizedBox(height: 10),
            Text("Rp ${moneyFormatter(amount: order.price)}",
                style: TextStyle(
                    color: ColorSchemes.text,
                    fontWeight: FontWeight.w600,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
