import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/core/utils/money_formatter.dart';
import 'package:courtly_vendor/presentation/blocs/order_detail_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/order_detail_state.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/// [OrderDetailPage] is a StatefulWidget that displays the order detail.
class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.orderId});

  /// [orderId] is the order id.
  final int orderId;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPage();
}

class _OrderDetailPage extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();

    // Fetch the order detail.
    context.read<OrderDetailBloc>().getOrderDetail(orderId: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorSchemes.primaryBackground,
        appBar: const BackableCenteredAppBar(title: "Order Detail"),
        body: SafeArea(
            child: BlocConsumer<OrderDetailBloc, OrderDetailState>(
                listener: (BuildContext context, OrderDetailState state) {
          // Check the state
          if (state is OrderDetailErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
            ));
          }
        }, builder: (BuildContext context, OrderDetailState state) {
          // Check the state
          if (state is! OrderDetailLoadedState) {
            return const LoadingScreen();
          }

          // Create date formatter
          final DateFormat dateFormatter = DateFormat("MMM dd, yyy");

          // Create time formatter
          final DateFormat timeFormatter = DateFormat("HH:mm");

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: PAGE_PADDING_MOBILE * 1.5),
              child: Column(
                children: [
                  Text(state.vendor.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorSchemes.text,
                      )),
                  Text(state.vendor.address,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorSchemes.text,
                      )),
                  const SizedBox(height: 20),
                  Text.rich(
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorSchemes.text,
                    ),
                    TextSpan(text: "Order ID: ", children: [
                      TextSpan(
                          text: state.orderDetail.midtransOrderId,
                          style: const TextStyle(fontWeight: FontWeight.bold))
                    ]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Booking Detail",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorSchemes.text,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Court Type",
                                    style: TextStyle(
                                        color: ColorSchemes.highlight,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    state.orderDetail.bookings[0].court.type,
                                    style: TextStyle(
                                        color: ColorSchemes.text,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Booking Date",
                                    style: TextStyle(
                                        color: ColorSchemes.highlight,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    dateFormatter
                                        .format(state.orderDetail.orderDate),
                                    style: TextStyle(
                                        color: ColorSchemes.text,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Booking Time Period",
                                    style: TextStyle(
                                        color: ColorSchemes.highlight,
                                        fontSize: 12),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      for (var i
                                          in state.orderDetail.bookings) ...[
                                        Text(
                                          "${timeFormatter.format(i.startTime)} - ${timeFormatter.format(i.endTime)} / ${i.court.name}",
                                          style: TextStyle(
                                              color: ColorSchemes.text,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )
                                      ]
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Detail",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorSchemes.text,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Created Date",
                                    style: TextStyle(
                                        color: ColorSchemes.highlight,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    dateFormatter
                                        .format(state.orderDetail.createdDate),
                                    style: TextStyle(
                                        color: ColorSchemes.text,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Booking Price",
                                    style: TextStyle(
                                        color: ColorSchemes.highlight,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    "Rp ${moneyFormatter(amount: state.orderDetail.price)}",
                                    style: TextStyle(
                                        color: ColorSchemes.text,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Application Service",
                                    style: TextStyle(
                                        color: ColorSchemes.highlight,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    "Rp ${moneyFormatter(amount: state.orderDetail.appFee)}",
                                    style: TextStyle(
                                        color: ColorSchemes.text,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(
                      12,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: ColorSchemes.subtle,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Total",
                          style: TextStyle(
                              color: ColorSchemes.text,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rp ${moneyFormatter(amount: state.orderDetail.price + state.orderDetail.appFee)}",
                          style: TextStyle(
                              color: ColorSchemes.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        })));
  }
}
