import 'package:bookia_app/features/place_order/data/models/governorate.dart';
import 'package:bookia_app/features/place_order/data/models/place_order_params.dart';
import 'package:bookia_app/features/place_order/data/repository/place_order_repo.dart';
import 'package:bookia_app/features/place_order/presentation/view_model/place_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());

  List<Governorate> governorates = [];

  Future<void> getGovernorates() async {
    emit(GovernoratesLoadingState());
    var data = await PlaceOrderRepo.getGovernorates();
    if (data != null && data.data != null) {
      governorates = data.data ?? [];
      emit(GovernoratesSuccessState());
    } else {
      emit(GovernoratesErrorState());
    }
  }

  // ✅ NEW: Place Order Method
  Future<void> placeOrder(PlaceOrderParams params) async {
    emit(PlaceOrderLoadingState());

    try {
      final response = await PlaceOrderRepo.placeOrder(params);

      if (response != null && response.data != null) {
        emit(PlaceOrderSuccessState(orderId: response.data!.id));
      } else {
        emit(PlaceOrderErrorState(message: 'Failed to place order'));
      }
    } catch (e) {
      emit(PlaceOrderErrorState(message: e.toString()));
    }
  }
}