/// [AddNewCourtFormDTO] is a class that contains the data of the new court form.
class AddNewCourtFormDTO {
  /// [pricePerHour] is the price per hour of the court
  final int pricePerHour;

  /// [courtsImage] is the image of the court
  final String courtsImage;

  AddNewCourtFormDTO({
    required this.pricePerHour,
    required this.courtsImage,
  });

  /// [toJson] is a method that converts the [AddNewCourtFormDTO] to a map.
  ///
  /// Returns a map.
  Map<String, dynamic> toJson() {
    return {
      'price_per_hour': pricePerHour,
      'courts_image': courtsImage,
    };
  }
}
