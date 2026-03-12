import 'package:bookia_app/features/home/data/model/best_seller_model/best_seller_model.dart';
import 'package:bookia_app/features/home/data/model/best_seller_model/products.dart';
import 'package:bookia_app/features/home/data/model/slider_model/slider.dart';
import 'package:bookia_app/features/home/data/model/slider_model/slider_model.dart';
import 'package:bookia_app/features/home/data/repo/home_repo.dart';
import 'package:bookia_app/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<Slider> sliders = [];
  List<Product> products = [];

  int yourActiveIndex = 0;

  Future<void> initLoadData() async {
    try {
      emit(HomeLoadingState());

      var responses = await Future.wait([
        HomeRepo.getSliders(),
        HomeRepo.getBestSellers(),
      ]);

      var slidersResponse = responses[0] as SliderModel?;
      var bestSellerResponse = responses[1] as BestSellerModel?;

      if (slidersResponse != null || bestSellerResponse != null) {
        sliders = slidersResponse?.data?.sliders ?? [];
        products = bestSellerResponse?.data?.products ?? [];

        emit(HomeSuccessState());
      } else {
        emit(HomeErrorState());
      }
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  void onChangeSlider(int index) {
    yourActiveIndex = index;
    emit(HomeSuccessState());
  }
}
