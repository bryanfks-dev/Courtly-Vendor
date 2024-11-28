import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/core/enums/sports.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly_vendor/presentation/widgets/bottom_modal_sheet.dart';
import 'package:courtly_vendor/presentation/widgets/filter_chips.dart';
import 'package:courtly_vendor/presentation/widgets/my_courts/court_card.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:courtly_vendor/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

/// [MyCourtsPage] is widget that represent my courts page.
/// It shows the list of courts.
class MyCourtsPage extends StatelessWidget {
  MyCourtsPage({super.key});

  /// [_ordersNotifer] is list of order history.
  final ValueNotifier<List<dynamic>> _ordersNotifer = ValueNotifier([1, 2, 3]);

  /// [_chipLabelItems] is the items of filter chip.
  final List<Widget> _chipLabelItems =
      Sports.values.map((e) => Text(e.label)).toList();

  /// [_selectedChipNotifier] is the selected chip via filter chips.
  final ValueNotifier<int> _selectedChipNotifier = ValueNotifier(0);

  /// [openAddCourtTypeModal] is the function to open the add court type modal.
  /// This function will open the modal to add new court type.
  ///
  /// - Parameters:
  ///  - context : BuildContext
  ///
  /// - Returns: void.
  void openAddCourtTypeModal(BuildContext context) {
    // Open the logout modal.
    showBottomModalSheet(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pick Court Type",
                    style: TextStyle(
                        color: ColorSchemes.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    child: HeroIcon(
                      HeroIcons.xMark,
                      color: ColorSchemes.highlight,
                      size: 20,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FilterChips(
                items: _chipLabelItems, selectedItem: _selectedChipNotifier),
            const SizedBox(
              height: 30,
            ),
            PrimaryButton(
                onPressed: () {},
                style: ButtonStyle(
                    minimumSize:
                        WidgetStateProperty.all(const Size.fromHeight(0))),
                child: const Text("Create Court",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.primaryBackground,
      appBar: const BackableCenteredAppBar(title: "My Courts"),
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child: SingleChildScrollView(
            physics: const PageScrollPhysics(),
            child: Column(children: [
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
                            "5",
                            style: TextStyle(
                                color: ColorSchemes.primaryBackground,
                                fontWeight: FontWeight.w500,
                                fontSize: 28),
                          ),
                          Text(
                            "Court Types",
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
                            "20",
                            style: TextStyle(
                                color: ColorSchemes.text,
                                fontWeight: FontWeight.w500,
                                fontSize: 28),
                          ),
                          Text(
                            "Total Courts",
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
                  Text("Courts",
                      style: TextStyle(
                          color: ColorSchemes.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  // GestureDetector(
                  //   onTap: () {
                  //     openAddCourtTypeModal(context);
                  //   },
                  //   child: Row(
                  //     children: [
                  //       HeroIcon(HeroIcons.plusCircle,
                  //           color: ColorSchemes.primary, size: 16),
                  //       const SizedBox(
                  //         width: 5,
                  //       ),
                  //       Text("Add",
                  //           style: TextStyle(
                  //               color: ColorSchemes.primary, fontSize: 12))
                  //     ],
                  //   ),
                  // )
                ],
              ),
              const SizedBox(height: 20),
              // ValueListenableBuilder(
              //     valueListenable: _ordersNotifer,
              //     builder: (BuildContext context, value, _) {
              //       return ListView.separated(
              //           shrinkWrap: true,
              //           physics: const NeverScrollableScrollPhysics(),
              //           itemBuilder: (BuildContext context, _) =>
              //               const CourtCard(),
              //           separatorBuilder: (BuildContext context, _) =>
              //               const SizedBox(height: 10),
              //           itemCount: value.length);
              //     })
              InkWell(
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.detailCourts);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorSchemes.subtle,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Basketball Court",
                            style: TextStyle(
                                color: ColorSchemes.text,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Total: ${3} Court(s)",
                            style: TextStyle(
                                color: ColorSchemes.text, fontSize: 10),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
