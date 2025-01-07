import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/core/enums/sports.dart';
import 'package:courtly_vendor/core/utils/safe_access.dart';
import 'package:courtly_vendor/presentation/blocs/orders_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/orders_state.dart';
import 'package:courtly_vendor/presentation/widgets/filter_chips.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/orders/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [OrdersPage] is widget that represent orders page.
/// It shows the list of orders history.
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPage();
}

class _OrdersPage extends State<OrdersPage> {
  /// [_chipLabelItems] is the items of filter chip.
  final List<Widget> _chipLabelItems =
      [const Text("All")] + Sports.values.map((e) => Text(e.label)).toList();

  /// [_selectedChipNotifier] is the selected chip via filter chips.
  final ValueNotifier<int> _selectedChipNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    // Fetch the orders.
    context.read<OrdersBloc>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<OrdersBloc, OrdersState>(
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

      return RefreshIndicator(
          onRefresh: () async {
            await context.read<OrdersBloc>().getOrders();
          },
          color: ColorSchemes.primary,
          backgroundColor: ColorSchemes.primaryBackground,
          child: SingleChildScrollView(
            child: StickyHeader(
                header: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: ColorSchemes.primaryBackground,
                        border: Border(
                            top: BorderSide(
                                width: 1, color: ColorSchemes.subtle),
                            bottom: BorderSide(
                                width: 1, color: ColorSchemes.subtle))),
                    child: Container(
                      margin: const EdgeInsets.only(left: PAGE_PADDING_MOBILE),
                      child: FilterChips(
                        items: _chipLabelItems,
                        selectedItem: _selectedChipNotifier,
                        onSelected: () {
                          // Fetch the orders again.
                          context.read<OrdersBloc>().getOrders(
                              courtType: listSafeAccess(
                                      list: Sports.values,
                                      index: _selectedChipNotifier.value - 1,
                                      defaultValue: null)
                                  ?.label);
                        },
                      ),
                    )),
                content: (state.orders.isEmpty)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                          child: Text(
                            "No Orders yet..",
                            style: TextStyle(color: ColorSchemes.highlight),
                          ),
                        ),
                      )
                    : SizedBox(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return OrderCard(order: state.orders[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 8),
                            itemCount: state.orders.length),
                      )),
          ));
    }));
  }
}
