/// [ProfileEvent] is the abstract class that will be extended by all the events
///  related to the vendor profile.
abstract class ProfileEvent {}

/// [FetchProfileEvent] is the event that is dispatched to fetch the vendor profile.
/// This event is dispatched when the vendor is to be fetched.
class FetchProfileEvent extends ProfileEvent {}
