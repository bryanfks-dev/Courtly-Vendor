import 'package:courtly_vendor/data/dto/reviews_response_dto.dart';
import 'package:courtly_vendor/domain/entities/review.dart';
import 'package:courtly_vendor/domain/entities/review_stars.dart';

/// [ReviewsStats] is a class that represents the reviews statistics.
class ReviewsStats {
  /// [totalRating] is the total rating of the reviews.
  final double totalRating;

  /// [reviewsTotal] is the total reviews.
  final int reviewsTotal;

  /// [reviewStars] is the review stars.
  final ReviewStars reviewStars;

  /// [reviews] is the list of reviews.
  final List<Review> reviews;

  ReviewsStats({
    required this.totalRating,
    required this.reviewsTotal,
    required this.reviewStars,
    required this.reviews,
  });

  /// [fromDTO] is a factory constructor to create a [ReviewsStats] from a DTO.
  ///
  /// Parameters:
  ///   - [dto] is a [ReviewsResponseDTO] object.
  ///
  /// Returns a [ReviewsStats] object.
  factory ReviewsStats.fromDTO(ReviewsResponseDTO dto) {
    return ReviewsStats(
      totalRating: dto.totalRating,
      reviewsTotal: dto.reviewsTotal,
      reviewStars: ReviewStars.fromDTO(dto.reviewStars),
      reviews:
          List<Review>.from(dto.reviews.map((x) => Review.fromDTO(x)).toList()),
    );
  }
}
