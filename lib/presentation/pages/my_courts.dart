import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/core/enums/sports.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly_vendor/presentation/widgets/my_courts/court_card.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [MyCourtsPage] is widget that represent my courts page.
/// It shows the list of courts.
class MyCourtsPage extends StatelessWidget {
  MyCourtsPage({super.key});

  /// [_courtCountNotifer] is a notifer for court count values
  final ValueNotifier<Map<String, int>> _courtCountNotifer = ValueNotifier({
    Sports.football.label: 0,
    Sports.badminton.label: 0,
    Sports.basketball.label: 0,
    Sports.tennis.label: 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.primaryBackground,
      appBar: const BackableCenteredAppBar(title: "My Courts"),
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child: SingleChildScrollView(
            physics: const PageScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Text("Courts",
                  style: TextStyle(
                      color: ColorSchemes.text,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                  valueListenable: _courtCountNotifer,
                  builder: (BuildContext context, value, _) {
                    // [entries] is the list of the map entries
                    final List<MapEntry<String, int>> entries =
                        value.entries.toList();

                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          // [entry] is the map entry
                          final MapEntry<String, int> entry = entries[index];

                          return CourtCard(
                              courtType: entry.key, courtCount: entry.value);
                        },
                        separatorBuilder: (BuildContext context, _) =>
                            const SizedBox(height: 10),
                        itemCount: value.length);
                  })
            ]),
          )),
    );
  }
}
