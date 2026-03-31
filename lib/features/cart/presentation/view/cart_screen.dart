
import 'package:bookia_app/core/widgets/my_body_view.dart';
import 'package:bookia_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:bookia_app/features/cart/presentation/widgets/cart_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body: MyBodyView(child: CartBooks()),
      ),
    );
  }
}
