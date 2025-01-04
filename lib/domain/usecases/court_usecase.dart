import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/booking_dto.dart';
import 'package:courtly_vendor/data/dto/court_dto.dart';
import 'package:courtly_vendor/data/dto/create_new_court_form_dto.dart';
import 'package:courtly_vendor/data/dto/courts_stats_response_dto.dart';
import 'package:courtly_vendor/data/dto/update_court_form_dto.dart';
import 'package:courtly_vendor/data/repository/api/court_repository.dart';
import 'package:courtly_vendor/domain/entities/booking.dart';
import 'package:courtly_vendor/domain/entities/court.dart';
import 'package:courtly_vendor/domain/entities/courts_stats.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

/// [CourtUsecase] is a class that is used to manage the usecase of the court.
class CourtUsecase {
  /// [courtRepository] is the repository for the court.
  final CourtRepository courtRepository;

  CourtUsecase({required this.courtRepository});

  /// [createNewCourt] is a method used to create a new court.
  ///
  /// Parameters:
  ///   - [pricePerHour] is the price per hour of the court.
  ///   - [courtType] is the type of the court.
  ///   - [imageFile] is the image file of the court.
  ///
  /// Returns a [Failure] object.
  Future<Failure?> createNewCourt(
      {required double pricePerHour,
      required File imageFile,
      required String courtType}) async {
    // Create the form dto
    final CreateNewCourtFormDTO formDto = CreateNewCourtFormDTO(
      pricePerHour: pricePerHour,
      courtImage: base64Encode(await imageFile.readAsBytes()),
    );

    // Make a POST request to the API.
    final Either<Failure, CourtDTO> res = await courtRepository.postNewCourt(
        formDto: formDto, courtType: courtType);

    // Check if the request is not success
    return res.fold((l) => l, (r) => null);
  }

  /// [getCourtsStats] is a method used to get the courts stats.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [CourtsStats] entity.
  Future<Either<Failure, CourtsStats>> getCourtsStats() async {
    final Either<Failure, CourtsStatsResponseDTO> res =
        await courtRepository.getCourtsStats();

    return res.fold((l) => Left(l), (r) => Right(CourtsStats.fromDTO(r)));
  }

  /// [getCourts] is a method used to get the courts.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Future] of [Either] a [Failure] or a list of [Court] entities.
  Future<Either<Failure, List<Court>>> getCourts(
      {required String courtType}) async {
    // Make a GET request to the API.
    final Either<Failure, List<CourtDTO>> res =
        await courtRepository.getCourts(courtType: courtType);

    return res.fold(
        (l) => Left(l), (r) => Right(r.map((e) => Court.fromDTO(e)).toList()));
  }

  /// [getCourtBookings] is a method used to get the court bookings.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Future] of [Either] a [Failure] or a list of [Booking] entities.
  Future<Either<Failure, List<Booking>>> getCourtBookings(
      {required String courtType, required DateTime date}) async {
    // Create a date formatter
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    // Make a GET request to the API.
    final Either<Failure, List<BookingDTO>> res =
        await courtRepository.getCourtBookings(
            courtType: courtType, date: dateFormatter.format(date));

    return res.fold((l) => Left(l),
        (r) => Right(r.map((e) => Booking.fromDTO(e)).toList()));
  }

  /// [updateCourt] is a method used to update the court.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///   - [pricePerHour] is the price per hour.
  ///
  /// Returns a [Future] of [Failure] or null.
  Future<Failure?> updateCourt(
      {required String courtType, required double pricePerHour}) async {
    // Create the update court form dto
    final UpdateCourtFormDTO formDto =
        UpdateCourtFormDTO(pricePerHour: pricePerHour);

    // Make a PUT request to the API.
    final Failure? res =
        await courtRepository.putCourt(courtType: courtType, formDto: formDto);

    return res;
  }
}
