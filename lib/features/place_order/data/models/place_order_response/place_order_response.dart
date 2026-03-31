class PlaceOrderResponse {
  final OrderData? data;
  final String message;
  final int status;

  PlaceOrderResponse({
    this.data,
    required this.message,
    required this.status,
  });

  factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    return PlaceOrderResponse(
      data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
      message: json['message'] as String? ?? '',
      status: json['status'] as int? ?? 0,
    );
  }
}

class OrderData {
  final int id;

  OrderData({required this.id});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] as int,
    );
  }
}