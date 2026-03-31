import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/my_body_view.dart';
import 'package:bookia_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:bookia_app/features/cart/presentation/widgets/cart_books.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/view/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              pushTo(context, ProfileDetails());
            },
            child: SvgPicture.asset(AppImages.back),
          ),
          title: Text('MyCart', style: TextStyles.title),
          centerTitle: true,
        ),
        body: MyBodyView(child: CartBooks()),
      ),
    );
  }
}
