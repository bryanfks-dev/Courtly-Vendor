import 'package:courtly_vendor/domain/entities/review.dart';

/// [ReviewsState] is the abstract class that will be extended by the different states of the reviews bloc.
abstract class ReviewsState {}

/// [ReviewsInitialState] is the state that represents the initial state of the reviews bloc.
/// This state is used when the reviews bloc is initialized.
class ReviewsInitialState extends ReviewsState {}

/// [ReviewsLoadingState] is the state that represents the loading state of the reviews bloc.
/// This state is used when the reviews bloc is fetching data from the server.
class ReviewsLoadingState extends ReviewsState {}

/// [ReviewsLoadedState] is the state that represents the loaded state of the reviews bloc.
/// This state is used when the reviews bloc has successfully fetched data from the server.
class ReviewsLoadedState extends ReviewsState {
  /// [reviews] is a list of reviews.
  final List<Review> reviews;

  ReviewsLoadedState({required this.reviews});
}

/// [ReviewsErrorState] is the state that represents the error state of the reviews bloc.
/// This state is used when the reviews bloc encounters an error while fetching data from the server.
class ReviewsErrorState extends ReviewsState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  ReviewsErrorState({required this.errorMessage});
}
