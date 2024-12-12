import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/reviews_response_dto.dart';
import 'package:courtly_vendor/data/repository/api/review_repository.dart';
import 'package:courtly_vendor/domain/entities/reviews_stats.dart';
import 'package:dartz/dartz.dart';

/// [ReviewUsecase] is a class that contains the business logic for the review feature.
/// This class is responsible for fetching the reviews from the repository.
class ReviewUsecase {
  /// [ReviewUsecase] is a class that contains the business logic for the review feature.
  final ReviewRepository reviewRepository;

  const ReviewUsecase({required this.reviewRepository});

  /// [getReviews] is a method that returns a list of reviews.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [ReviewsStats] entity.
  Future<Either<Failure, ReviewsStats>> getReviews({int? rating}) async {
    // Fetch the reviews from the repository.
    final Either<Failure, ReviewsResponseDTO> reviews =
        await reviewRepository.getReviews(rating: rating);

    return reviews.fold(
      (l) => Left(l),
      (r) => Right(ReviewsStats.fromDTO(r)),
    );
  }
}
