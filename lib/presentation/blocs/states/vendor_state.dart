import 'package:courtly_vendor/domain/entities/vendor.dart';

/// [VendorState] is the abstract class of vendor state.
abstract class VendorState {}

/// [VendorInitialState] is the initial state of the vendor.
class VendorInitialState extends VendorState {}

/// [VendorLoadingState] is the state when the vendor data is being fetched.
class VendorLoadingState extends VendorState {}

/// [VendorLoadedState] is the state when the vendor data is fetched successfully.
class VendorLoadedState extends VendorState {
  /// [vendor] is the vendor data.
  final Vendor vendor;

  VendorLoadedState({required this.vendor});
}

/// [VendorErrorState] is the state when an error occurs while fetching the vendor data.
class VendorErrorState extends VendorState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  VendorErrorState({required this.errorMessage});
}
