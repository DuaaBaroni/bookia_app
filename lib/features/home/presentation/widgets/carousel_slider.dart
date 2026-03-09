import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int yourActiveIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 5,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    AppImages.bg,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
          options: CarouselOptions(
            height: 150,
            viewportFraction: 1,
            autoPlay: true,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                yourActiveIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Gap(14),
        AnimatedSmoothIndicator(
          activeIndex: yourActiveIndex,
          count: 6,
          effect: ExpandingDotsEffect(
            dotHeight: 7,
            dotWidth: 7,
            activeDotColor: AppColors.primaryColor,
            dotColor: AppColors.borderColor,
            expansionFactor: 4,
          ),
        ),
      ],
    );
  }
}
