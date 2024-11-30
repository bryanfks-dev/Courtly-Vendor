import 'dart:async';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_response_dto.dart';
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
    try {
      // Make a GET request to the API.
      ResponseDTO<VendorResponseDTO> res = await vendorRepository.getVendor();

      // Check if the request is successful.
      if (!res.success) {
        return Left(ServerFailure(res.message));
      }

      return Right(Vendor.fromDTO(res.data!.vendor));
    } on SocketException catch (_) {
      return const Left(NetworkFailure("Network Failure"));
    } on TimeoutException catch (_) {
      return const Left(NetworkFailure("Request Timeout"));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
