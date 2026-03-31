import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/dialogs.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:bookia_app/features/cart/presentation/view_model/cart_state.dart';
import 'package:bookia_app/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:bookia_app/features/place_order/presentation/view/place_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBooks extends StatelessWidget {
  const CartBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CheckoutLoadingState) {
          showLoadingDialog(context);
        } else if (state is CheckoutSuccessState) {
          Navigator.pop(context);
          var cubit = context.read<CartCubit>();
          pushTo(context, PlaceOrderScreen(total: cubit.total));
        } else if (state is CheckoutErrorState) {
          Navigator.pop(context); // Close loading dialog
          showMyDialog(context, 'Failed to checkout. Please try again.');
        }
      },
      buildWhen: (_, state) =>
          state is CartSuccessState ||
          state is CartErrorState ||
          state is CartLoadingState,
      builder: (context, state) {
        if (state is CartSuccessState) {
          var cubit = context.read<CartCubit>();
          if (cubit.products.isEmpty) {
            return const Center(child: Text('No books in cart'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.products.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(
                      item: cubit.products[index],
                      onRemove: () {
                        cubit.removeFromCart(cubit.products[index].itemId ?? 0);
                      },
                      onUpdate: (count) {
                        cubit.updateCart(
                          cubit.products[index].itemId ?? 0,
                          count,
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  Text('Total: ${cubit.total}', style: TextStyles.subtitle2),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainButton(
                  onPressed: () {
                    cubit.checkout();
                  },
                  text: 'Checkout',
                ),
              ),
            ],
          );
        } else {
          return SizedBox();
          //  ListShimmer();
        }
      },
    );
  }
}
