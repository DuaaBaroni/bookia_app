// ignore_for_file: strict_top_level_inference

import 'package:bookia_app/core/services/dio/apis.dart';
import 'package:bookia_app/core/services/dio/dio_provider.dart';
import 'package:bookia_app/features/home/data/model/slider_model/slider_model.dart';
import 'package:bookia_app/features/home/presentation/view_model/slider_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitialState());

  SliderModel? sliderImage;

  getSlider() {
    emit(SliderLoadingState());
    DioProvider.get(endpoint: Apis.slider, queryParameters: {})
        .then((value) {
          sliderImage = SliderModel.fromJson(value.data);
          emit(SliderSuccessState());
        })
        .catchError((onError) {
          emit(SliderErrorState());
        });
  }
}
