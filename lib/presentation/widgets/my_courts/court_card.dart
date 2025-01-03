import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/presentation/pages/my_court_detail.dart';
import 'package:flutter/material.dart';

/// [CourtCard] is a widget that displays the court card.
class CourtCard extends StatelessWidget {
  const CourtCard(
      {super.key, required this.courtType, required this.courtCount});

  // [courtType] is the type of court
  final String courtType;

  // [courtCount] is the count of courts
  final int courtCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyCourtDetail(courtType: courtType)));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(
                color: ColorSchemes.subtle,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$courtType Court",
                style: TextStyle(
                    color: ColorSchemes.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Total: $courtCount Court(s)",
                style: TextStyle(color: ColorSchemes.text, fontSize: 10),
              )
            ],
          ),
        ));
  }
}
