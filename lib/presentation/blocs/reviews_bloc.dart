import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/entities/reviews_stats.dart';
import 'package:courtly_vendor/domain/usecases/review_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/reviews_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsBloc extends Cubit<ReviewsState> {
  /// [reviewUsecase] is the usecase for reviews.
  final ReviewUsecase reviewUsecase;

  ReviewsBloc({required this.reviewUsecase}) : super(ReviewsInitialState());

  /// [getReviews] is a method that fetches the reviews from the server.
  ///
  /// Parameters:
  ///   - [rating] is the rating of the reviews.
  ///
  /// Returns a [Future] of [void]
  Future<void> getReviews({int? rating}) async {
    emit(ReviewsLoadingState());

    // Fetch the reviews from the server.
    final Either<Failure, ReviewsStats> result =
        await reviewUsecase.getReviews(rating: rating);

    result.fold(
      (failure) => emit(ReviewsErrorState(errorMessage: failure.errorMessage)),
      (stats) => emit(ReviewsLoadedState(reviewsStats: stats)),
    );
  }
}
