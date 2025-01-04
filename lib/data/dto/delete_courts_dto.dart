/// [DeleteCourtsDTO] is a class that is used to convert the object to
/// a JSON object.
class DeleteCourtsDTO {
  /// [courtIds] is a list of court ids to be deleted from the database.
  final List<int> courtIds;

  DeleteCourtsDTO({required this.courtIds});

  /// [toJson] is a method that converts the object to a JSON object.
  ///
  /// Returns a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'court_ids': courtIds,
    };
  }
}
