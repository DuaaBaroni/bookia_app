// ignore_for_file: avoid_print

import 'package:bookia_app/core/services/local/shared_preferences.dart';
import 'package:bookia_app/features/product_details.dart/presentation/view_model/wishlist_action_state.dart';
import 'package:bookia_app/features/wishlist/data/model/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistActionCubit extends Cubit<ProductDetailsState> {
  WishlistActionCubit() : super(ProductDetailsInitial());

  Future<void> addToWishlist(int productId) async {
    print('START: Adding product $productId to wishlist');
    emit(ProductDetailsLoadingState());
    
    try {
      var data = await WishlistRepo.addToWishlist(productId);
      print('API Response received: ${data != null ? "Success" : "Null"}');
      
      if (data != null) {
        var products = data.data?.products ?? [];
        print('SUCCESS: ${products.length} products in wishlist');
        
        SharedPref.cacheWishlistIds(products);
        emit(ProductDetailsSuccessState(msg: 'Added To Wishlist'));
      } else {
        print('ERROR: API returned null');
        emit(ProductDetailsErrorState());
      }
    } catch (e) {
      print('EXCEPTION in addToWishlist: $e');
      emit(ProductDetailsErrorState());
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    print('START: Removing product $productId from wishlist');
    emit(ProductDetailsLoadingState());
    
    try {
      var data = await WishlistRepo.removeFromWishlist(productId);
      print('API Response received: ${data != null ? "Success" : "Null"}');
      
      if (data != null) {
        var products = data.data?.products ?? [];
        print('SUCCESS: ${products.length} products remaining in wishlist');
        
        SharedPref.cacheWishlistIds(products);
        emit(ProductDetailsSuccessState(msg: 'Removed From Wishlist'));
      } else {
        print('ERROR: API returned null');
        emit(ProductDetailsErrorState());
      }
    } catch (e) {
      print('EXCEPTION in removeFromWishlist: $e');
      emit(ProductDetailsErrorState());
    }
  }

  bool isProductInWishlist(int productId) {
    var wishlistIds = SharedPref.getWishlistIds();
    bool isInWishlist = wishlistIds.contains(productId);
    print('CHECK: Product $productId in wishlist? $isInWishlist');
    return isInWishlist;
  }
}