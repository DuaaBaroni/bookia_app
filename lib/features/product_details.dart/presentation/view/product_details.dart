import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/features/home/data/model/best_seller_model/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
     final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right:20, bottom: 20),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(AppImages.back),
                    IconButton(
                      onPressed: () {
                      pushTo(context, ProductDetails(product: product
                      ));
                      },
                      icon: SvgPicture.asset(AppImages.bookmarkSvg),
                    ),
                  ],
                ),
                Gap(10),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                  child: Image.network(product.image??"", height: 260))),
                Gap(14),
                Text(
                  textAlign: TextAlign.center,
                  product.name??"", style: TextStyles.headline.copyWith(
                     fontSize: 23
                  )),
                Gap(6),
                Text(
                  "Broché",
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                Gap(16),
                Text(
                  product.description??"",
                  style: TextStyles.caption2.copyWith(
                    color: AppColors.black,
                    height: 1.5,
                  ),
                ),
                Gap(20),
                Row(
                  children: [
                    Expanded(child: Text("\$${product.price}", style: TextStyles.title)),
                    Expanded(
                      child: MainButton(
                        minWidth: 250,
                        bgColor: AppColors.black,
                        textColor: AppColors.borderColor,
                        onPressed: () {},
                        text: "Add To Cart",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
