import 'dart:developer';
import 'package:bookia_app/features/order_history/data/model/order_history_model/order_model.dart';

class OrderHistoryResponse {
  final List<Order> orders;
  final Meta? meta;
  final Links? links;
  final String message;
  final int status;

  OrderHistoryResponse({
    required this.orders,
    this.meta,
    this.links,
    required this.message,
    required this.status,
  });

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    try {
      log('📦 Parsing OrderHistoryResponse...');
      log('   Raw JSON: $json');

      // ✅ FIXED: Handle direct array in 'data'
      final data = json['data'];
      
      List<Order> ordersList = [];
      Meta? metaData;
      Links? linksData;

      if (data is List) {
        // ✅ Case 1: data is direct array []
        log('   Data is direct array, length: ${data.length}');
        ordersList = data
            .map((order) => Order.fromJson(order as Map<String, dynamic>))
            .toList();
      } else if (data is Map<String, dynamic>) {
        // ✅ Case 2: data is object with orders, meta, links
        log('   Data is object with nested fields');
        
        if (data['orders'] != null) {
          final orders = data['orders'] as List;
          ordersList = orders
              .map((order) => Order.fromJson(order as Map<String, dynamic>))
              .toList();
        }
        
        if (data['meta'] != null) {
          metaData = Meta.fromJson(data['meta'] as Map<String, dynamic>);
        }
        
        if (data['links'] != null) {
          linksData = Links.fromJson(data['links'] as Map<String, dynamic>);
        }
      }

      log('✅ Parsed ${ordersList.length} orders');

      return OrderHistoryResponse(
        orders: ordersList,
        meta: metaData,
        links: linksData,
        message: json['message'] as String? ?? '',
        status: json['status'] as int? ?? 0,
      );
    } catch (e, stackTrace) {
      log('❌ OrderHistoryResponse parsing error: $e');
      log('❌ StackTrace: $stackTrace');
      rethrow;
    }
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
      total: json['total'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 0,
      currentPage: json['current_page'] as int? ?? 0,
      lastPage: json['last_page'] as int? ?? 0,
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