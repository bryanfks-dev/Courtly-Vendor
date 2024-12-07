import 'package:courtly_vendor/domain/entities/courts_stats.dart';

/// [MyCourtsState] is a class that represents the state of the my courts page.
abstract class MyCourtsState {}

/// [MyCourtsInitialState] is a class that represents the initial state of the my courts page.
/// This state is emitted when the page is loaded.
class MyCourtsInitialState extends MyCourtsState {}

/// [MyCourtsLoadingState] is a class that represents the loading state of the my courts page.
/// This state is emitted when the page is loading.
class MyCourtsLoadingState extends MyCourtsState {}

/// [MyCourtsLoadedState] is a class that represents the loaded state of the my courts page.
/// This state is emitted when the page is loaded.
class MyCourtsLoadedState extends MyCourtsState {
  /// [courtsStats] is the statistics of the courts.
  final CourtsStats courtsStats;

  MyCourtsLoadedState({required this.courtsStats});
}

/// [MyCourtsErrorState] is a class that represents the error state of the my courts page.
class MyCourtsErrorState extends MyCourtsState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  MyCourtsErrorState({required this.errorMessage});
}
