import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/presentation/blocs/orders_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/orders_state.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/orders/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [OrdersPage] is widget that represent orders page.
/// It shows the list of orders history.
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPage();
}

class _OrdersPage extends State<OrdersPage> {
  /// [_cardGap] is the gap between each order card.
  final double _cardGap = 7;

  @override
  void initState() {
    super.initState();

    // Fetch the orders.
    context.read<OrdersBloc>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
        listener: (BuildContext context, OrdersState state) {
      // Show error message if there is an error.
      if (state is OrdersErrorState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errorMessage)));
      }
    }, builder: (BuildContext context, OrdersState state) {
      // Show loading screen if the state is not OrderLoadedState.
      if (state is! OrdersLoadedState) {
        return const LoadingScreen();
      }

      // Show no orders found message if there are no orders.
      if (state.orders.isEmpty) {
        return Center(
            child: Text('No orders found',
                style: TextStyle(fontSize: 16, color: ColorSchemes.highlight)));
      }

      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: _cardGap,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      OrderCard(order: state.orders[index]),
                  separatorBuilder: (BuildContext context, _) => SizedBox(
                        height: _cardGap,
                      ),
                  itemCount: state.orders.length)
            ],
          ),
        ),
      );
    });
  }
}
