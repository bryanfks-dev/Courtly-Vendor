/// [CourtDTO] is a data transfer object that represents the court data.
class CourtDTO {
  /// [id] is the unique identifier of the court.
  final int id;

  /// [name] is the name of the court.
  final String name;

  /// [type] is the type of the court.
  final String type;

  /// [price] is the price of the court.
  final double price;

  /// [imageUrl] is the URL of the image of the court.
  final String imageUrl;

  CourtDTO({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.imageUrl,
  });

  /// [fromJson] is a factory method to create a [CourtDTO] from a map.
  ///
  /// Parameters:
  ///   - [json] is a map that contains the court data.
  ///
  /// Returns a [CourtDTO] object.
  factory CourtDTO.fromJson(Map<String, dynamic> json) {
    return CourtDTO(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      price: json['price'] + .0,
      imageUrl: json['image_url'],
    );
  }
}
