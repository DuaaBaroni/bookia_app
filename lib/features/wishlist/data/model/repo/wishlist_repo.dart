// ignore_for_file: avoid_print

import 'package:bookia_app/core/services/dio/apis.dart';
import 'package:bookia_app/core/services/dio/dio_provider.dart';
import 'package:bookia_app/core/services/local/shared_preferences.dart';
import 'package:bookia_app/features/wishlist/data/model/wishlist_model/wishlist_model.dart';

class WishlistRepo {
  static Future<WishlistModel?> getWishlist() async {
    print('GET Wishlist - Endpoint: ${Apis.wishlist}');
    print('Token: ${SharedPref.getToken()?.substring(0, 20)}...');
    
    try {
      var response = await DioProvider.get(
        endpoint: Apis.wishlist,
        queryParameters: {"page": 1},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
     );
      
      print('GET Wishlist Response - Status: ${response.statusCode}');
      print('Response Data: ${response.data}');
      
      if (response.statusCode == 200) {
        return WishlistModel.fromJson(response.data);
      } else {
        print(' Unexpected status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('GET Wishlist Exception: $e');
      print('Exception Type: ${e.runtimeType}');
      return null;
    }
  }

  static Future<WishlistModel?> addToWishlist(int productId) async {
    print('ADD to Wishlist - Product ID: $productId');
    print('Endpoint: ${Apis.addToWishlist}');
    print('Token: ${SharedPref.getToken()?.substring(0, 20)}...');
    
    try {
      var response = await DioProvider.post(
        endpoint: Apis.addToWishlist,
        queryParameters: {"page": 1},
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      
      print('ADD Response - Status: ${response.statusCode}');
      print('Response Data: ${response.data}');
      
      if (response.statusCode == 200) {
        return WishlistModel.fromJson(response.data);
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('ADD to Wishlist Exception: $e');
      print('Exception Type: ${e.runtimeType}');
      return null;
    }
  }

  static Future<WishlistModel?> removeFromWishlist(int productId) async {
    print('REMOVE from Wishlist - Product ID: $productId');
    print('Endpoint: ${Apis.removeFromWishlist}');
    print('Token: ${SharedPref.getToken()?.substring(0, 20)}...');
    
    try {
      var response = await DioProvider.post(
        endpoint: Apis.removeFromWishlist,
        queryParameters: {"page": 1},
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      
      print('REMOVE Response - Status: ${response.statusCode}');
      print('Response Data: ${response.data}');
      
      if (response.statusCode == 200) {
        return WishlistModel.fromJson(response.data);
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('REMOVE from Wishlist Exception: $e');
      print('Exception Type: ${e.runtimeType}');
      return null;
    }
  }
}