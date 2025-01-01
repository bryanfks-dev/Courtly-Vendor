import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/core/utils/money_formatter.dart';
import 'package:courtly_vendor/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// [OrderCard] is a widget that displays a card
/// containing order information.
///
/// It is used in the [OrdersPage] widget.
class OrderCard extends StatelessWidget {
  OrderCard({super.key, required this.order});

  final Order order;

  /// [_dateFormatter] is the date formatter.
  final DateFormat _dateFormatter = DateFormat("MMM d, yyyy");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: PAGE_PADDING_MOBILE),
      decoration: BoxDecoration(color: ColorSchemes.primaryBackground),
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
              Text(_dateFormatter.format(order.date),
                  style: TextStyle(
                      color: ColorSchemes.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 12)),
            ],
          ),
          Text("${order.courtType} Court",
              style: TextStyle(color: ColorSchemes.highlight, fontSize: 12)),
          const SizedBox(height: 3),
          Text("Rp ${moneyFormatter(amount: order.price + order.appFee)}",
              style: TextStyle(
                  color: ColorSchemes.text,
                  fontWeight: FontWeight.w700,
                  fontSize: 12)),
        ],
      ),
    );
  }
}
