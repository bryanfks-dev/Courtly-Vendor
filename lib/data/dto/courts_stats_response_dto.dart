/// [CourtsStatsResponseDTO] is a DTO class that is used to represent
/// the court stats response.
class CourtsStatsResponseDTO {
  /// [totalCourts] is the total number of courts.
  final int totalCourts;

  /// [footballCourtCount] is the number of football courts.
  final int footballCourtCount;

  /// [basketballCourtCount] is the number of basketball courts.
  final int basketballCourtCount;

  /// [tennisCourtCount] is the number of tennis courts.
  final int tennisCourtCount;

  /// [volleyballCourtCount] is the number of volleyball courts.
  final int volleyballCourtCount;

  /// [badmintonCourtCount] is the number of badminton courts.
  final int badmintonCourtCount;

  CourtsStatsResponseDTO({
    required this.totalCourts,
    required this.footballCourtCount,
    required this.basketballCourtCount,
    required this.tennisCourtCount,
    required this.volleyballCourtCount,
    required this.badmintonCourtCount,
  });

  /// [fromJson] is a factory method that is used to convert the JSON
  /// object to the DTO.
  ///
  /// Parameters:
  ///   - [json] is the JSON object.
  ///
  /// Returns a [CourtsStatsResponseDTO] object.
  factory CourtsStatsResponseDTO.fromJson(Map<String, dynamic> json) {
    return CourtsStatsResponseDTO(
      totalCourts: json['total_court_count'] as int,
      footballCourtCount: json['football_court_count'] as int,
      basketballCourtCount: json['basketball_court_count'] as int,
      tennisCourtCount: json['tennis_court_count'] as int,
      volleyballCourtCount: json['volleyball_court_count'] as int,
      badmintonCourtCount: json['badminton_court_count'] as int,
    );
  }
}
