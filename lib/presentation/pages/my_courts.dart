import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly_vendor/presentation/widgets/my_courts/court_card.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class MyCourtsPage extends StatelessWidget {
  MyCourtsPage({super.key});

  final ValueNotifier<List<dynamic>> _ordersNotifer = ValueNotifier([1, 2, 3]);

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
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        HeroIcon(HeroIcons.plusCircle,
                            color: ColorSchemes.primary, size: 16),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("Add",
                            style: TextStyle(
                                color: ColorSchemes.primary, fontSize: 12))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                  valueListenable: _ordersNotifer,
                  builder: (BuildContext context, value, _) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, _) =>
                            const CourtCard(),
                        separatorBuilder: (BuildContext context, _) =>
                            const SizedBox(height: 10),
                        itemCount: value.length);
                  })
            ]),
          )),
    );
  }
}
