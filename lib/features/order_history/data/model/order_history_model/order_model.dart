import 'package:flutter/material.dart';

class Order {
  final int id;
  final String orderCode;
  final String orderDate;
  final String status;
  final String total;

  Order({
    required this.id,
    required this.orderCode,
    required this.orderDate,
    required this.status,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      orderCode: json['order_code'] as String,
      orderDate: json['order_date'] as String,
      status: json['status'] as String,
      total: json['total'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_code': orderCode,
      'order_date': orderDate,
      'status': status,
      'total': total,
    };
  }

  // Helper getters
  String get formattedDate {
    // Convert 2023-08-14 to 14/08/2023
    final parts = orderDate.split('-');
    if (parts.length == 3) {
      return '${parts[2]}/${parts[1]}/${parts[0]}';
    }
    return orderDate;
  }

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'shipping':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}