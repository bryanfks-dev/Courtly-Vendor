import 'package:courtly_vendor/data/dto/review_dto.dart';
import 'package:courtly_vendor/data/dto/review_stars_dto.dart';

/// [ReviewsResponseDTO] is a data transfer object for reviews response.
class ReviewsResponseDTO {
  /// [totalRating] is the total rating of the reviews.
  final double totalRating;

  /// [reviewTotal] is the total number of reviews.
  final int reviewTotal;

  /// [reviewStars] is the review stars.
  final ReviewStarsDTO reviewStars;

  /// [reviews] is the reviews.
  final List<ReviewDTO> reviews;

  ReviewsResponseDTO({
    required this.totalRating,
    required this.reviewTotal,
    required this.reviewStars,
    required this.reviews,
  });

  /// [fromJson] is a factory method that creates a [ReviewsResponseDTO] instance from a JSON object.
  ///
  /// Parameters:
  ///   - [json]: A JSON object.
  ///
  /// Returns a [ReviewsResponseDTO] instance.
  factory ReviewsResponseDTO.fromJson(Map<String, dynamic> json) {
    return ReviewsResponseDTO(
      totalRating: json['total_rating'],
      reviewTotal: json['review_total'],
      reviewStars: ReviewStarsDTO.fromJson(json['review_stars']),
      reviews: (json['reviews'] as List)
          .map((review) => ReviewDTO.fromJson(review))
          .toList(),
    );
  }
}
