import 'dart:io';

/// [CreateNewCourtFormValidator] is a class that validates the Add New Court form.
/// It checks if the price per hour and courts image are valid or not.
class CreateNewCourtFormValidator {
  /// [validatePricePerHour] is a method that validates the price per hour.
  ///
  /// Parameters:
  ///   - [price]: The price per hour to validate.
  ///
  /// Returns a [String] message.
  String? validatePricePerHour({required String price}) {
    // Check if the price per hour is empty.
    if (price.isEmpty) {
      return "Price per hour is required";
    }

    // Check if the price per hour is not a number.
    if (int.tryParse(price) == null) {
      return "Price per hour must be a number";
    }

    // Check if the price per hour is less than or equal to 0.
    if (int.parse(price) <= 0) {
      return "Price per hour must be greater than 0";
    }

    return null;
  }

  /// [validateCourtImage] is a method that validates the court image.
  ///
  /// Parameters:
  ///   - [image]: The image to validate.
  ///
  /// Returns a [String] message.
  String? validateCourtImage({required File? image}) {
    // Check if the image is empty.
    if (image == null) {
      return "Court image is required";
    }

    return null;
  }
}
