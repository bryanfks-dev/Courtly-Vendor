import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/reviews_response_dto.dart';
import 'package:courtly_vendor/data/repository/api/review_repository.dart';
import 'package:courtly_vendor/domain/entities/review.dart';
import 'package:dartz/dartz.dart';

class ReviewUsecase {
  /// [ReviewUsecase] is a class that contains the business logic for the review feature.
  final ReviewRepository reviewRepository;

  const ReviewUsecase({required this.reviewRepository});

  /// [getReviews] is a method that returns a list of reviews.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [List] of [Review] entity.
  Future<Either<Failure, List<Review>>> getReviews() async {
    // Fetch the reviews from the repository.
    final Either<Failure, ReviewsResponseDTO> reviews =
        await reviewRepository.getReviews();

    // Check if there is failure
    if (reviews.isLeft()) {
      return Left(reviews.fold(
          (l) => l, (r) => const UnknownFailure("An unknown error occurred")));
    }

    return Right(reviews.fold(
      (l) => <Review>[],
      (r) => r.reviews.map((dto) => Review.fromDTO(dto)).toList(),
    ));
  }
}
