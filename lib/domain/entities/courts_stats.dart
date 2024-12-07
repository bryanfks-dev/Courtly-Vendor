import 'package:courtly_vendor/data/dto/courts_stats_response_dto.dart';

/// [CourtsStats] is an entity class that is used to represent the court stats.
class CourtsStats {
  /// [totalCourts] is the total number of courts.
  final int totalCourts;

  /// [footballCourtCount] is the number of football courts.
  final int footballCourtCount;

  /// [basketballCourtCount] is the number of basketball courts.
  final int basketballCourtCount;

  /// [volleyballCourtCount] is the number of volleyball courts.
  final int volleyballCourtCount;

  /// [tennisCourtCount] is the number of tennis courts.
  final int tennisCourtCount;

  /// [badmintonCourtCount] is the number of badminton courts.
  final int badmintonCourtCount;

  CourtsStats({
    required this.totalCourts,
    required this.footballCourtCount,
    required this.basketballCourtCount,
    required this.volleyballCourtCount,
    required this.tennisCourtCount,
    required this.badmintonCourtCount,
  });

  /// [fromDTO] is a factory method that is used to convert the DTO to the entity.
  ///
  /// Parameters:
  ///   - [dto] is the DTO object.
  ///
  /// Returns a [CourtsStats] object.
  factory CourtsStats.fromDTO(CourtsStatsResponseDTO dto) {
    return CourtsStats(
      totalCourts: dto.totalCourts,
      footballCourtCount: dto.footballCourtCount,
      basketballCourtCount: dto.basketballCourtCount,
      volleyballCourtCount: dto.volleyballCourtCount,
      tennisCourtCount: dto.tennisCourtCount,
      badmintonCourtCount: dto.badmintonCourtCount,
    );
  }
}
