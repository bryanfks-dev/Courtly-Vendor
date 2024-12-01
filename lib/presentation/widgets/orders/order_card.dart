import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/core/utils/money_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// [OrderCard] is a widget that displays a card
/// containing order information.
///
/// It is used in the [OrdersPage] widget.
class OrderCard extends StatelessWidget {
  OrderCard(
      {super.key,
      required this.date,
      required this.userName,
      required this.courtType,
      required this.bookStartTime,
      required this.bookEndTime,
      required this.price});

  /// [date] is the date of the order.
  final DateTime date;

  /// [userName] is the name of the user who made the order.
  final String userName;

  /// [courtType] is the type of the court.
  final String courtType;

  /// [bookStartTime] is the start time of the booking.
  final DateTime bookStartTime;

  /// [bookEndTime] is the end time of the booking.
  final DateTime bookEndTime;

  /// [price] is the price of the booking.
  final double price;

  /// [_dateFormatter] is the date formatter.
  final DateFormat _dateFormatter = DateFormat("MMM d, yyyy");

  /// [_timeFormatter] is the time formatter.
  final DateFormat _timeFormatter = DateFormat("HH:mm");

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
              Text(_dateFormatter.format(date),
                  style: TextStyle(
                      color: ColorSchemes.highlight,
                      fontWeight: FontWeight.w500,
                      fontSize: 12)),
              Text(
                  "${_timeFormatter.format(bookStartTime)} - ${_timeFormatter.format(bookEndTime)}",
                  style: TextStyle(
                      color: ColorSchemes.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12)),
            ],
          ),
          const SizedBox(height: 3),
          Text(userName,
              style: TextStyle(
                  color: ColorSchemes.text,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis)),
          Text("$courtType Court",
              style: TextStyle(color: ColorSchemes.text, fontSize: 14)),
          const SizedBox(height: 3),
          Text("Rp ${moneyFormatter(amount: price)}",
              style: TextStyle(
                  color: ColorSchemes.text,
                  fontWeight: FontWeight.w700,
                  fontSize: 12)),
        ],
      ),
    );
  }
}
