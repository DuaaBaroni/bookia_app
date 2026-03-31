import 'dart:developer';
import 'package:bookia_app/core/services/dio/apis.dart';
import 'package:bookia_app/core/services/dio/dio_provider.dart';
import 'package:bookia_app/core/services/local/shared_preferences.dart';
import 'package:bookia_app/features/place_order/data/models/governorates_response.dart';
import 'package:bookia_app/features/place_order/data/models/place_order_params.dart';
import 'package:bookia_app/features/place_order/data/models/place_order_response/place_order_response.dart';

class PlaceOrderRepo {
  static Future<GovernoratesResponse?> getGovernorates() async {
    try {
      var response = await DioProvider.get(endpoint: Apis.governorates);
      if (response.statusCode == 200) {
        return GovernoratesResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<PlaceOrderResponse?> placeOrder(PlaceOrderParams params) async {
    try {
      final token = SharedPref.getToken();
      
      log('PLACE ORDER Request');
      log('Data: ${params.toJson()}');

      var response = await DioProvider.post(
        endpoint: Apis.placeOrder, // 'place-order'
        data: params.toJson(),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('✅ Response Status: ${response.statusCode}');
      log('✅ Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return PlaceOrderResponse.fromJson(response.data);
      } else {
        log('❌ Failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('❌ Place Order Error: $e');
      return null;
    }
  }
}