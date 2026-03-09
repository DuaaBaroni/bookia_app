import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BestSellerBooks extends StatelessWidget {
  const BestSellerBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Best Sellers', style: TextStyles.title),
        Gap(30),
        GridView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 11,
            crossAxisSpacing: 11,
            childAspectRatio: .6,
          ),
          itemBuilder: (context, index) {
            return BookCard();
          },
        ),
      ],
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondaryColor,
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AppImages.bg,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(10),
          Text('The Psychology of Money', style: TextStyles.body),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$25', style: TextStyles.body),
              SizedBox(
                height: 30,
                child: MainButton(
                  minWidth: 70,
                  minHeight: 30,
                  bgColor: AppColors.darkColor,
                  text: 'Buy',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
