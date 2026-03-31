import 'package:bookia_app/features/order_history/data/model/order_history_model/order_history_model.dart';
import 'package:dio/dio.dart';
import 'package:bookia_app/core/services/dio/dio_provider.dart';
import 'package:bookia_app/core/services/local/shared_preferences.dart';

class OrderHistoryRepo {
  static Future<OrderHistoryResponse?> getOrderHistory() async {
    try {
      final token = SharedPref.getToken();

      if (token == null || token.isEmpty) {
        return null;
      }

      var response = await DioProvider.get(
        endpoint: 'order-history',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return OrderHistoryResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }
}
