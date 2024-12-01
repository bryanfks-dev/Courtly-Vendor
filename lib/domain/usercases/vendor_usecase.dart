import 'dart:async';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/vendor_dto.dart';
import 'package:courtly_vendor/data/repository/api/vendor_repository.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';
import 'package:dartz/dartz.dart';

/// [VendorUsecase] is a class that contains the business logic of the vendor process.
class VendorUsecase {
  /// [vendorRepository] is the repository for vendor.
  final VendorRepository vendorRepository;

  VendorUsecase({required this.vendorRepository});

  /// [getVendor] is a method to get the vendor data.
  Future<Either<Failure, Vendor>> getVendor() async {
    // Make a GET request to the API.
    final Either<Failure, VendorDTO> res = await vendorRepository.getVendor();

    // Check if the request is not success
    return res.fold((l) => left(l), (r) => right(Vendor.fromDTO(r)));
  }
}
