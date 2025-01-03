import 'package:courtly_vendor/domain/entities/booking.dart';
import 'package:courtly_vendor/domain/entities/court.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';

/// [MyCourtDetailState] is the abstract class that will be extended by the states
/// of the [MyCourtDetailBloc].
abstract class MyCourtDetailState {}

/// [MyCourtDetailInitialState] is the initial state of the [MyCourtDetailBloc].
/// This state will be used to initialize the [MyCourtDetailBloc].
class MyCourtDetailInitialState extends MyCourtDetailState {}

/// [MyCourtDetailLoadingState] is the loading state of the [MyCourtDetailBloc].
/// This state will be used to show a loading indicator while the data is being
/// fetched.
class MyCourtDetailLoadingState extends MyCourtDetailState {}

/// [MyCourtDetailLoadedState] is the loaded state of the [MyCourtDetailBloc].
/// This state will be used to display the court details.
class MyCourtDetailLoadedState extends MyCourtDetailState {
  /// [courts] is the list of courts.
  final List<Court> courts;

  /// [bookings] is the list of booking
  final List<Booking> bookings;

  /// [vendor] is the [Vendor] object that will be used to display the
  /// vendor details.
  final Vendor vendor;

  MyCourtDetailLoadedState(
      {required this.courts, required this.bookings, required this.vendor});
}

/// [MyCourtDetailErrorState] is the error state of the [MyCourtDetailBloc].
/// This state will be used to show an error message if the data fetching fails.
class MyCourtDetailErrorState extends MyCourtDetailState {
  /// [errorMessage] is the error message that will be displayed.
  final String errorMessage;

  MyCourtDetailErrorState({required this.errorMessage});
}
