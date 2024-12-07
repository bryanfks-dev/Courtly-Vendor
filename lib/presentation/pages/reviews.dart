import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/widgets/filter_chips.dart';
import 'package:courtly_vendor/presentation/widgets/reviews/rating_bar.dart';
import 'package:courtly_vendor/presentation/widgets/reviews/review_card.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [ReviewsPage] is a page to show user's reviews.
class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPage();
}

class _ReviewsPage extends State<ReviewsPage> {
  /// [_selectedChipNotifier] is the selected chip via filter chips.
  final ValueNotifier<int> _selectedChipNotifier = ValueNotifier(0);

  /// [_userReviewsNotifier] is the list of user reviews.
  final ValueNotifier<List<dynamic>> _userReviewsNotifier =
      ValueNotifier([1, 2, 3, 1, 2, 3, 1, 2, 3]);

  @override
  Widget build(BuildContext context) {
    /// [chipLabelItems] is the items of filter chip.
    final List<Widget> chipLabelItems = <Widget>[const Text("All")] +
        List.generate(
            4,
            (e) => Row(
                  children: [
                    Text((e + 1).toString()),
                    const SizedBox(width: 5),
                    HeroIcon(HeroIcons.star,
                        style: HeroIconStyle.solid,
                        size: 16,
                        color: ColorSchemes.star)
                  ],
                ));

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: PAGE_PADDING_MOBILE,
              right: PAGE_PADDING_MOBILE,
            ),
            color: ColorSchemes.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        HeroIcon(HeroIcons.star,
                            style: HeroIconStyle.solid,
                            size: 36,
                            color: ColorSchemes.star),
                        const SizedBox(
                          width: 5,
                        ),
                        Text.rich(
                            style: TextStyle(
                                color: ColorSchemes.text,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                            TextSpan(text: "4.9", children: [
                              TextSpan(
                                  text: " / 5.0",
                                  style: TextStyle(
                                      color: ColorSchemes.highlight,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12))
                            ]))
                      ],
                    ),
                    Text.rich(
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: ColorSchemes.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        TextSpan(text: "Based on\n", children: [
                          TextSpan(
                              text: "14 reviews",
                              style: TextStyle(
                                  color: ColorSchemes.highlight,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12))
                        ]))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    RatingBar(rating: 1, value: 0),
                    const SizedBox(
                      height: 5,
                    ),
                    RatingBar(rating: 2, value: 0.2),
                    const SizedBox(
                      height: 5,
                    ),
                    RatingBar(rating: 3, value: 0.4),
                    const SizedBox(
                      height: 5,
                    ),
                    RatingBar(rating: 4, value: 0.75),
                    const SizedBox(
                      height: 5,
                    ),
                    RatingBar(rating: 5, value: 0.8)
                  ],
                )
              ],
            ),
          ),
          StickyHeader(
              header: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: ColorSchemes.primaryBackground,
                    border: Border(
                        top: BorderSide(width: 1, color: ColorSchemes.subtle),
                        bottom:
                            BorderSide(width: 1, color: ColorSchemes.subtle))),
                child: Container(
                  margin: const EdgeInsets.only(left: PAGE_PADDING_MOBILE),
                  child: FilterChips(
                      items: chipLabelItems,
                      selectedItem: _selectedChipNotifier),
                ),
              ),
              content: SizedBox(
                child: ValueListenableBuilder(
                    valueListenable: _userReviewsNotifier,
                    builder:
                        (BuildContext context, List<dynamic> userReview, _) {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ReviewCard(
                                userProfile: "",
                                userName: "EL Gasing",
                                reviewDate: DateTime.now(),
                                rate: 3,
                                review: "This is a review from user.");
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 10),
                          itemCount: userReview.length);
                    }),
              ))
        ],
      ),
    ));
  }
}
