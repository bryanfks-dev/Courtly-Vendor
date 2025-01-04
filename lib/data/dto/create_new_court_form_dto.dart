/// [CreateNewCourtFormDTO] is a class that contains the data of the new court form.
class CreateNewCourtFormDTO {
  /// [pricePerHour] is the price per hour of the court
  final double pricePerHour;

  /// [courtImage] is the image of the court
  final String courtImage;

  CreateNewCourtFormDTO({
    required this.pricePerHour,
    required this.courtImage,
  });

  /// [toJson] is a method that converts the [CreateNewCourtFormDTO] to a map.
  ///
  /// Returns a map.
  Map<String, dynamic> toJson() {
    return {
      'price_per_hour': pricePerHour,
      'court_image': courtImage,
    };
  }
}
