import 'package:courtly_vendor/data/dto/order_detail_dto.dart';

/// [OrderDetailResponseDTO] is a class that represents the response of the
/// order detail API.
class OrderDetailResponseDTO {
  /// [orderDetail] is an instance of [OrderDetailDTO].
  final OrderDetailDTO orderDetail;

  OrderDetailResponseDTO({required this.orderDetail});

  factory OrderDetailResponseDTO.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponseDTO(
      orderDetail: OrderDetailDTO.fromJson(json['order_detail']),
    );
  }
}
