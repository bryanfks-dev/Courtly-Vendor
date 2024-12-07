import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/courts_response_dto.dart';
import 'package:courtly_vendor/data/dto/add_new_court_form_dto.dart';
import 'package:courtly_vendor/data/dto/courts_stats_response_dto.dart';
import 'package:courtly_vendor/data/repository/api/court_repository.dart';
import 'package:courtly_vendor/domain/entities/courts_stats.dart';
import 'package:dartz/dartz.dart';

/// [CourtUsecase] is a class that is used to manage the usecase of the court.
class CourtUsecase {
  /// [courtRepository] is the repository for the court.
  final CourtRepository courtRepository;

  CourtUsecase({required this.courtRepository});

  /// [addNewCourt] is a method used to add a new court.
  ///
  /// Parameters:
  ///   - [formDto] is the form data.
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Failure] object.
  Future<Failure?> addNewCourt(
      {required AddNewCourtFormDTO formDto, required String courtType}) async {
    // Make a POST request to the API.
    final Either<Failure, CourtsResponseDTO> res = await courtRepository
        .postNewCourt(formDto: formDto, courtType: courtType);

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
}
