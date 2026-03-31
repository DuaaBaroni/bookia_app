import 'package:bookia_app/features/order_history/data/model/order_history_model/order_model.dart';

class OrderHistoryResponse {
  final List<Order> orders;
  final Meta meta;
  final Links links;
  final String message;
  final int status;

  OrderHistoryResponse({
    required this.orders,
    required this.meta,
    required this.links,
    required this.message,
    required this.status,
  });

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryResponse(
      orders: (json['data']['orders'] as List)
          .map((order) => Order.fromJson(order))
          .toList(),
      meta: Meta.fromJson(json['data']['meta']),
      links: Links.fromJson(json['data']['links']),
      message: json['message'] as String? ?? '',
      status: json['status'] as int,
    );
  }
}

class Meta {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;

  Meta({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'] as int,
      perPage: json['per_page'] as int,
      currentPage: json['current_page'] as int,
      lastPage: json['last_page'] as int,
    );
  }
}

class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }
}