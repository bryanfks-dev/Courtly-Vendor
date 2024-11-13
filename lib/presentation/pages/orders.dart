import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/presentation/widgets/orders/order_card.dart';
import 'package:flutter/material.dart';

/// [OrdersPage] is widget that represent orders page.
/// It shows the list of orders history.
class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  /// [_orders] is list of order history.
  final ValueNotifier<List<dynamic>> _orders = ValueNotifier([1, 2, 3]);

  /// [cardGap] is the gap between each order card.
  final double cardGap = 7;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: cardGap,
            ),
            ValueListenableBuilder(
                valueListenable: _orders,
                builder: (BuildContext context, value, _) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, _) =>
                          const OrderCard(),
                      separatorBuilder: (BuildContext context, _) => SizedBox(
                            height: cardGap,
                          ),
                      itemCount: value.length);
                })
          ],
        ),
      ),
    );
  }
}
