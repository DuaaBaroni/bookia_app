import 'package:bookia_app/core/services/local/shared_preferences.dart';
import 'package:bookia_app/features/home/data/model/best_seller_model/products.dart';
import 'package:bookia_app/features/wishlist/data/model/repo/wishlist_repo.dart';
import 'package:bookia_app/features/wishlist/presentation/view_model/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<Product> products = [];

  Future<void> getWishlist() async {
    emit(WishlistLoadingState());
    var data = await WishlistRepo.getWishlist();
    if (data != null) {
      products = data.data?.products ?? [];
      SharedPref.cacheWishlistIds(products);
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState());
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(WishlistLoadingState());
    var data = await WishlistRepo.removeFromWishlist(productId);
    if (data != null) {
      products = data.data?.products ?? [];
      SharedPref.cacheWishlistIds(products);
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState());
    }
  }
}
