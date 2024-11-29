/// [VendorDTO] is a data transfer object for vendor.
class VendorDTO {
  /// [id] is the id of the vendor.
  final String id;

  /// [name] is the name of the vendor.
  final String name;

  /// [address] is the address of the vendor.
  final String address;

  /// [email] is the email of the vendor.
  final String email;

  /// [openTime] is the opening time of the vendor.
  final String openTime;

  /// [closeTime] is the closing time of the vendor.
  final String closeTime;

  VendorDTO({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.openTime,
    required this.closeTime,
  });

  /// [fromJson] is a factory method to create a [VendorDTO] from a map.
  ///
  /// Returns a [VendorDTO] object.
  factory VendorDTO.fromJson(Map<String, dynamic> json) {
    return VendorDTO(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      email: json['email'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
    );
  }
}
