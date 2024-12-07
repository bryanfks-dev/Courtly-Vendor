/// [Sports] is an enum that contains the sports that
/// the user can choose from.
///
/// Sport contains [label] that is the name of the sport.
enum Sports {
  football("Football"),
  badminton("Badminton"),
  basketball("Basketball"),
  volleyball("Volleyball"),
  tennis("Tennis");

  /// [label] is the name of the sport and used in the UI to
  /// show the sport name.
  final String label;

  const Sports(this.label);
}
