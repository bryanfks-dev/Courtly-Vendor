import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/domain/entities/review.dart';
import 'package:courtly_vendor/presentation/widgets/reviews/star_row.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

/// [ReviewCard] is a card to show the review of the user.
/// This card will show the user's name, profile, date of the review, rate,
/// and the review itself.
class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });

  /// [review] is the review object.
  final Review review;

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
                          shape: BoxShape.circle,
                          image: review.user.profilePictureUrl.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                      review.user.profilePictureUrl),
                                  fit: BoxFit.cover)
                              : null),
                      child: review.user.profilePictureUrl.isEmpty
                          ? HeroIcon(
                              HeroIcons.userCircle,
                              color: ColorSchemes.highlight,
                              style: HeroIconStyle.solid,
                              size: 72,
                            )
                          : null),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    review.user.username,
                    style: TextStyle(
                        color: ColorSchemes.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Text(
                DateFormat("MMM, dd yyyy").format(review.date),
                style: TextStyle(
                  color: ColorSchemes.highlight,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text("${review.courtType} Court",
              style: TextStyle(color: ColorSchemes.highlight, fontSize: 12)),
          const SizedBox(height: 5),
          StarRow(rate: review.rating),
          const SizedBox(height: 5),
          Text(
            review.review,
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
