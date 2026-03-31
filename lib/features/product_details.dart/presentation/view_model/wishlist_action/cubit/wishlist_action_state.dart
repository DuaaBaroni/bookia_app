class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoadingState extends ProductDetailsState {}

class ProductDetailsSuccessState extends ProductDetailsState {
  final String msg;

  ProductDetailsSuccessState({required this.msg});
}

class ProductDetailsErrorState extends ProductDetailsState {}