import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/my_body_view.dart';
import 'package:bookia_app/features/home/data/model/best_seller_model/products.dart';
import 'package:bookia_app/features/home/presentation/view/home_view.dart';
import 'package:bookia_app/features/home/presentation/widgets/best_seller.dart';
import 'package:bookia_app/features/product_details.dart/presentation/view_model/cart_action/cart_icon.dart';
import 'package:bookia_app/features/product_details.dart/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailsArg {
  final Product product;
  final String source;
  DetailsArg({required this.product, required this.source});
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            pop(context);
          },

          child: Icon(Icons.arrow_back_ios, size: 16),
        ),
        actions: [WishlistActionWidget(id: product.id ?? 0)],
      ),
      body: MyBodyView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: product.id ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image ?? '',
                    width: 180,
                    height: 270,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(11),
              Text(
                product.name ?? '',
                style: TextStyles.headline,
                textAlign: TextAlign.center,
              ),
              Gap(11),
              Text(
                product.category ?? '',
                style: TextStyles.caption1.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(20),
              Text(
                product.description ?? '',
                textAlign: TextAlign.justify,
                style: TextStyles.caption2.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 5, 22, 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${product.price} \$', style: TextStyles.title),
            CartActionWidget(id: product.id ?? 0),
          ],
        ),
      ),
    );
  }
}
