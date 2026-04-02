import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/features/home/data/model/best_seller_model/products.dart';
import 'package:bookia_app/features/product_details.dart/presentation/view/product_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.product,
    this.onRemoveFromWishlist,
    this.onRefresh,
  });
  final Product product;
  final Function()? onRemoveFromWishlist;
  final Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, ProductDetails(product: product));

      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.secondaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: product.id ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Gap(10),
            SizedBox(
              height: 45,
              child: Text(
                product.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.body,
              ),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.priceAfterDiscount ?? product.price}',
                  style: TextStyles.body,
                ),
                onRemoveFromWishlist != null
                    ? IconButton(
                        onPressed: onRemoveFromWishlist,
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(30, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.errorColor,
                        ),
                      )
                    : SizedBox(
                        height: 30,
                        child: MainButton(
                          minWidth: 70,
                          minHeight: 30,
                          bgColor: AppColors.darkColor,
                          text: 'Buy'.tr(),
                          onPressed: () {},
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}