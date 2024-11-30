import 'package:courtly_vendor/data/dto/vendor_dto.dart';
import 'package:intl/intl.dart';

/// [Vendor] is a class that represents a vendor entity.
class Vendor {
  /// [id] is the unique identifier of the vendor.
  final int id;

  /// [name] is the name of the vendor.
  final String name;

  /// [address] is the address of the vendor.
  final String address;

  /// [email] is the email of the vendor.
  final String email;

  /// [openTime] is the opening time of the vendor.
  final DateTime openTime;

  /// [closeTime] is the closing time of the vendor.
  final DateTime closeTime;

  Vendor({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.openTime,
    required this.closeTime,
  });

  /// [fromDTO] is a factory method to create a [Vendor] from a [VendorDTO].
  ///
  /// Parameters:
  ///   - [dto] is the [VendorDTO] object.
  ///
  /// Returns a [Vendor] object.
  factory Vendor.fromDTO(VendorDTO dto) {
    return Vendor(
      id: dto.id,
      name: dto.name,
      address: dto.address,
      email: dto.email,
      openTime: DateFormat("hh:mm").parse(dto.openTime),
      closeTime: DateFormat("hh:mm").parse(dto.closeTime),
    );
  }
}
