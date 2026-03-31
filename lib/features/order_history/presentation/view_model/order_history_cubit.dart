import 'package:bookia_app/features/order_history/data/model/order_history_model/order_model.dart';
import 'package:bookia_app/features/order_history/data/repo/order_history_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia_app/features/order_history/presentation/view_model/order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());

  List<Order> orders = [];
  int totalOrders = 0;
  int currentPage = 1;
  int lastPage = 1;

  Future<void> getOrderHistory() async {
    emit(OrderHistoryLoading());

    try {
      final response = await OrderHistoryRepo.getOrderHistory();

      if (response != null) {
        orders = response.orders;
        totalOrders = response.meta.total;
        currentPage = response.meta.currentPage;
        lastPage = response.meta.lastPage;

        emit(OrderHistorySuccess());
      } else {
        emit(OrderHistoryError(message: 'Failed to load order history'));
      }
    } catch (e) {
      emit(OrderHistoryError(message: e.toString()));
    }
  }

  void refresh() {
    getOrderHistory();
  }
}
