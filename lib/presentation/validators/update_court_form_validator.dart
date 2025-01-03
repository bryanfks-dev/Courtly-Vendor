/// [UpdateCourtFormValidator] is a class that validates the Update Court Form.
/// It checks if the price per hour.
class UpdateCourtFormValidator {
  /// [validatePricePerHour] is a method that validates the price per hour.
  ///
  /// Parameters:
  ///   - [pricePerHour]: The price per hour to validate.
  ///
  /// Returns a [String] message.
  String? validatePricePerHour({required String pricePerHour}) {
    // Check if empty
    if (pricePerHour.isEmpty) {
      return "Price per hour is required";
    }

    // Parse the price per hour
    final parsedPricePerHour = int.tryParse(pricePerHour);

    // Check if price is invalid
    if (parsedPricePerHour == null) {
      return "Invalid price";
    }

    if (parsedPricePerHour <= 0) {
      return "Price per hour must be greater than 0";
    }

    return null;
  }
}
