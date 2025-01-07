import 'package:courtly_vendor/domain/entities/vendor.dart';

/// [ProfileState] is the abstract class of profile state.
abstract class ProfileState {}

/// [ProfileInitialState] is the initial state of the vendor.
class ProfileInitialState extends ProfileState {}

/// [ProfileLoadingState] is the state when the vendor data is being fetched.
class ProfileLoadingState extends ProfileState {}

/// [ProfileLoadedState] is the state when the vendor data is fetched successfully.
class ProfileLoadedState extends ProfileState {
  /// [vendor] is the vendor data.
  final Vendor vendor;

  ProfileLoadedState({required this.vendor});
}

/// [ProfileErrorState] is the state when an error occurs while fetching the vendor data.
class ProfileErrorState extends ProfileState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  ProfileErrorState({required this.errorMessage});
}
