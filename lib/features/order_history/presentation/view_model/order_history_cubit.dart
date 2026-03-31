import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia_app/features/order_history/data/model/order_history_model/order_model.dart';
import 'package:bookia_app/features/order_history/data/repo/order_history_repo.dart';
import 'package:bookia_app/features/order_history/presentation/view_model/order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());

  List<Order> orders = [];

  Future<void> getOrderHistory() async {
    try {
      emit(OrderHistoryLoading());
      
      log('🔵 OrderHistoryCubit: Fetching order history...');

      final response = await OrderHistoryRepo.getOrderHistory();

      if (response != null) {
        orders = response.orders;
        log('✅ OrderHistoryCubit: Loaded ${orders.length} orders');
        emit(OrderHistorySuccess());
      } else {
        log('❌ OrderHistoryCubit: Response is null');
        emit(OrderHistoryError(message: 'Failed to load order history'));
      }
    } catch (e) {
      log('❌ OrderHistoryCubit Error: $e');
      emit(OrderHistoryError(message: e.toString()));
    }
  }

  Future<void> refresh() async {
    await getOrderHistory();
  }
}