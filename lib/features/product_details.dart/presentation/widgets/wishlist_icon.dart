import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/widgets/custom_svg_picture.dart';
import 'package:bookia_app/core/widgets/dialogs.dart';
import 'package:bookia_app/features/product_details.dart/presentation/view_model/wishlist_action/cubit/wishlist_action_cubit.dart';
import 'package:bookia_app/features/product_details.dart/presentation/view_model/wishlist_action/cubit/wishlist_action_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishlistActionWidget extends StatelessWidget {
  const WishlistActionWidget({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistActionCubit(),
      child: BlocConsumer<WishlistActionCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsSuccessState) {
            pop(context);
            showMyDialog(context, state.msg, type: DialogType.success);
          } else if (state is ProductDetailsErrorState) {
            pop(context);
            showMyDialog(context, 'Something went wrong');
          } else if (state is ProductDetailsLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          var cubit = context.read<WishlistActionCubit>();
          return IconButton(
            onPressed: () {
              if (cubit.isProductInWishlist(id)) {
                cubit.removeFromWishlist(id);
              } else {
                context.read<WishlistActionCubit>().addToWishlist(id);
              }
            },
            icon: cubit.isProductInWishlist(id)
                ? CustomSvgPicture(
                    path: AppImages.bookmarkSvg,
                    color: AppColors.primaryColor,
                  )
                : SvgPicture.asset(AppImages.bookmarkSvg),
          );
        },
      ),
    );
  }
}