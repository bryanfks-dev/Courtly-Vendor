import 'package:courtly_vendor/domain/entities/booking.dart';
import 'package:courtly_vendor/domain/entities/court.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';

/// [MyCourtDetailState] is the abstract class that will be extended by the states
/// of the [MyCourtDetailBloc].
abstract class MyCourtDetailState {}

/// [MyCourtDetailInitialState] is the initial state of the [MyCourtDetailBloc].
/// This state will be used to initialize the [MyCourtDetailBloc].
class MyCourtDetailInitialState extends MyCourtDetailState {}

/// [MyCourtDetailFetchingState] is the fetching state of the [MyCourtDetailBloc].
/// This state will be used to show a loading indicator while fetching the data.
class MyCourtDetailFetchingState extends MyCourtDetailState {}

/// [MyCourtDetailFetchedState] is the fetched state of the [MyCourtDetailBloc].
/// This state will be used to display the fetched data.
class MyCourtDetailFetchedState extends MyCourtDetailState {
  /// [courts] is the list of courts.
  final List<Court> courts;

  /// [bookings] is the list of booking
  final List<Booking> bookings;

  /// [vendor] is the [Vendor] object that will be used to display the
  /// vendor details.
  final Vendor vendor;

  MyCourtDetailFetchedState(
      {required this.courts, required this.bookings, required this.vendor});
}

/// [MyCourtDetailUpdatingState] is the updating state of the [MyCourtDetailBloc].
/// This state will be used to show a loading indicator while updating the data.
class MyCourtDetailUpdatingState extends MyCourtDetailState {}

/// [MyCourtDetailUpdatedState] is the updated state of the [MyCourtDetailBloc].
/// This state will be used to show a success message if the data is updated
/// successfully.
class MyCourtDetailUpdatedState extends MyCourtDetailState {}

/// [MyCourtDetailUpdateErrorState] is the delete error state of [MyCourtDetailBloc].
/// This state will be used to show an error message if the data updating fails.
class MyCourtDetailUpdateErrorState extends MyCourtDetailState {
  /// [errorMessage] is the error message that will be displayed.
  final dynamic errorMessage;

  MyCourtDetailUpdateErrorState({required this.errorMessage});
}

/// [MyCourtDetailDeletingState] is the deleting state of the [MyCourtDetailBloc].
/// This state will be used to show a loading indicator while deleting the data.
class MyCourtDetailDeletingState extends MyCourtDetailState {}

/// [MyCourtDetailDeletedState] is the deleted state of the [MyCourtDetailBloc].
/// This state will be used to show a success message if the data is deleted
/// successfully.
class MyCourtDetailDeletedState extends MyCourtDetailState {}

/// [MyCourtDetailErrorState] is the error state of the [MyCourtDetailBloc].
/// This state will be used to show an error message if the data fetching fails.
class MyCourtDetailErrorState extends MyCourtDetailState {
  /// [errorMessage] is the error message that will be displayed.
  final String errorMessage;

  MyCourtDetailErrorState({required this.errorMessage});
}
