import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/domain/entities/review.dart';
import 'package:courtly_vendor/presentation/blocs/reviews_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/reviews_state.dart';
import 'package:courtly_vendor/presentation/widgets/filter_chips.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/reviews/rating_bar.dart';
import 'package:courtly_vendor/presentation/widgets/reviews/review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  /// [_chipLabelItems] is the items of filter chip.
  final List<Widget> _chipLabelItems = <Widget>[const Text("All")] +
      List.generate(
          5,
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

  /// [_calculateStarRating] is a function to calculate the star rating.
  /// This function will calculate the star rating based on the star count and reviews total.
  ///
  /// Parameters:
  ///   - [starCount] is an [int] of the star count.
  ///   - [reviewsTotal] is an [int] of the total reviews.
  ///
  /// Returns a [double] of the star rating.
  double _calculateStarRating(
      {required int starCount, required int reviewsTotal}) {
    if (reviewsTotal == 0) {
      return 0;
    }

    return starCount / reviewsTotal;
  }

  @override
  void initState() {
    super.initState();

    // Fetch the reviews.
    context.read<ReviewsBloc>().getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsBloc, ReviewsState>(
        listener: (BuildContext context, ReviewsState state) {
      // Show error message if there is an error.
      if (state is ReviewsErrorState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errorMessage)));
      }
    }, builder: (BuildContext context, ReviewsState state) {
      // Show loading screen if the state is not ReviewsLoadedState.
      if (state is! ReviewsLoadedState) {
        return const LoadingScreen();
      }

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
                              TextSpan(
                                  text:
                                      state.reviewsStats.totalRating.toString(),
                                  children: [
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
                                text:
                                    "${state.reviewsStats.reviewsTotal} reviews",
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
                      RatingBar(
                          rating: 1,
                          value: _calculateStarRating(
                              starCount: state.reviewsStats.reviewStars.oneStar,
                              reviewsTotal: state.reviewsStats.reviewsTotal)),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar(
                          rating: 2,
                          value: _calculateStarRating(
                              starCount: state.reviewsStats.reviewStars.twoStar,
                              reviewsTotal: state.reviewsStats.reviewsTotal)),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar(
                          rating: 3,
                          value: _calculateStarRating(
                              starCount:
                                  state.reviewsStats.reviewStars.threeStar,
                              reviewsTotal: state.reviewsStats.reviewsTotal)),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar(
                          rating: 4,
                          value: _calculateStarRating(
                              starCount:
                                  state.reviewsStats.reviewStars.fourStar,
                              reviewsTotal: state.reviewsStats.reviewsTotal)),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar(
                          rating: 5,
                          value: _calculateStarRating(
                              starCount:
                                  state.reviewsStats.reviewStars.fiveStar,
                              reviewsTotal: state.reviewsStats.reviewsTotal))
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
                          bottom: BorderSide(
                              width: 1, color: ColorSchemes.subtle))),
                  child: Container(
                    margin: const EdgeInsets.only(left: PAGE_PADDING_MOBILE),
                    child: FilterChips(
                      items: _chipLabelItems,
                      selectedItem: _selectedChipNotifier,
                      onTap: () {},
                    ),
                  ),
                ),
                content: BlocBuilder<ReviewsBloc, ReviewsState>(
                  builder: (BuildContext context, ReviewsState state) {
                    // Show loading screen if the state is not ReviewsLoadedState.
                    if (state is! ReviewsLoadedState) {
                      return const LoadingScreen();
                    }

                    // Show no reviews found if there is no reviews.
                    if (state.reviewsStats.reviews.isEmpty) {
                      return Container(
                          padding: const EdgeInsets.only(top: 56),
                          child: Center(
                              child: Text("No reviews found.",
                                  style: TextStyle(
                                      color: ColorSchemes.highlight))));
                    }

                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          /// [review] is the review object.
                          final Review review =
                              state.reviewsStats.reviews[index];

                          return ReviewCard(
                              userProfile: review.user.profilePictureUrl,
                              userName: review.user.username,
                              reviewDate: review.date,
                              rate: review.rating,
                              review: review.review);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 10),
                        itemCount: state.reviewsStats.reviews.length);
                  },
                ))
          ],
        ),
      ));
    });
  }
}
