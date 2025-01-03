/// [UpdateCourtFormDTO] is a class that contains the data of the court to
/// be updated.
class UpdateCourtFormDTO {
  /// [pricePerHour] is the price per hour of the court to be updated.
  final double pricePerHour;

  UpdateCourtFormDTO({required this.pricePerHour});

  /// [toJson] is a method that converts the [UpdateCourtFormDTO] instance to a JSON object.
  ///
  /// Returns a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'price_per_hour': pricePerHour,
    };
  }
}
