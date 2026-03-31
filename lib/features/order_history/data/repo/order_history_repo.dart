import 'dart:developer';
import 'package:bookia_app/core/services/dio/apis.dart';
import 'package:bookia_app/features/order_history/data/model/order_history_model/order_history_model.dart';
import 'package:dio/dio.dart';
import 'package:bookia_app/core/services/dio/dio_provider.dart';
import 'package:bookia_app/core/services/local/shared_preferences.dart';

class OrderHistoryRepo {
  static Future<OrderHistoryResponse?> getOrderHistory() async {
    try {
      final token = SharedPref.getToken();

      log('🔵 GET ORDER HISTORY Request');
      log('   Endpoint: ${Apis.orderHistory}');
      log('   Token: ${token?.substring(0, 20)}...');

      if (token == null || token.isEmpty) {
        log('❌ No token found!');
        return null;
      }

      var response = await DioProvider.get(
        endpoint: Apis.orderHistory, 
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('✅ Response Status: ${response.statusCode}');
      log('📦 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final orderResponse = OrderHistoryResponse.fromJson(response.data);
        log('✅ Parsed ${orderResponse.orders.length} orders');
        return orderResponse;
      } else {
        log('❌ Failed with status: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      log('❌ DioException: ${e.response?.statusCode}');
      log('❌ Error Response: ${e.response?.data}');
      log('❌ Error Message: ${e.message}');
      return null;
    } catch (e) {
      log('❌ Exception: $e');
      return null;
    }
  }
}