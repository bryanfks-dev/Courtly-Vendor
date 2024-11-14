import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/widgets/reviews/star_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// [ReviewCard] is a card to show the review of the user.
/// This card will show the user's name, profile, date of the review, rate,
/// and the review itself.
class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.userName,
    required this.userProfile,
    required this.reviewDate,
    required this.rate,
    required this.review,
  });

  /// [userName] is the name of the user.
  final String userName;

  /// [userProfile] is the profile of the user.
  final String userProfile;

  /// [reviewDate] is the date of the review.
  final DateTime reviewDate;

  /// [rate] is the rate of the review.
  final int rate;

  /// [review] is the review of the user.
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PAGE_PADDING_MOBILE),
      color: ColorSchemes.primaryBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: ColorSchemes.subtle,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                        color: ColorSchemes.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Text(
                DateFormat("MMM, dd yyyy", "en_US").format(reviewDate),
                style: TextStyle(
                  color: ColorSchemes.highlight,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text("Football Court",
              style: TextStyle(color: ColorSchemes.highlight, fontSize: 12)),
          const SizedBox(height: 5),
          StarRow(rate: rate),
          const SizedBox(height: 5),
          Text(
            review,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: ColorSchemes.text,
            ),
          ),
        ],
      ),
    );
  }
}
