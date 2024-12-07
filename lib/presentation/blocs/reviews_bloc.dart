import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/domain/entities/review.dart';
import 'package:courtly_vendor/domain/usercases/review_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/reviews_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsBloc extends Cubit<ReviewsState> {
  /// [reviewUsecase] is the usecase for reviews.
  final ReviewUsecase reviewUsecase;

  ReviewsBloc({required this.reviewUsecase}) : super(ReviewsInitialState());

  /// [getReviews] is a method that fetches the reviews from the server.
  ///
  /// Returns a [Future] of [void]
  Future<void> getReviews() async {
    emit(ReviewsLoadingState());

    // Fetch the reviews from the server.
    final Either<Failure, List<Review>> result =
        await reviewUsecase.getReviews();

    result.fold(
      (failure) => emit(ReviewsErrorState(errorMessage: failure.errorMessage)),
      (reviews) => emit(ReviewsLoadedState(reviews: reviews)),
    );
  }
}
