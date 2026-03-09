import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/widgets/custom_svg_picture.dart';
import 'package:bookia_app/features/home/presentation/widgets/best_seller.dart';
import 'package:bookia_app/features/home/presentation/widgets/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CustomSvgPicture(path: AppImages.logoSvg, height: 30),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CustomSvgPicture(path: AppImages.searchSvg),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              HomeSlider(),
              Gap(30),
              BestSellerBooks(),
              Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
