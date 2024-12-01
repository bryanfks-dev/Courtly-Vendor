/// [VendorEvent] is the abstract class that will be extended by all the events related to the vendor.
abstract class VendorEvent {}

/// [FetchVendorEvent] is the event that is dispatched to fetch the vendor.
/// This event is dispatched when the vendor is to be fetched.
class FetchVendorEvent extends VendorEvent {}
