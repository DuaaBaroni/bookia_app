class PlaceOrderState {}

class PlaceOrderInitial extends PlaceOrderState {}

// Governorates States
class GovernoratesLoadingState extends PlaceOrderState {}

class GovernoratesSuccessState extends PlaceOrderState {}

class GovernoratesErrorState extends PlaceOrderState {}

// Place Order States
class PlaceOrderLoadingState extends PlaceOrderState {}

class PlaceOrderSuccessState extends PlaceOrderState {
  final int orderId;

  PlaceOrderSuccessState({required this.orderId});
}

class PlaceOrderErrorState extends PlaceOrderState {
  final String message;

  PlaceOrderErrorState({required this.message});
}