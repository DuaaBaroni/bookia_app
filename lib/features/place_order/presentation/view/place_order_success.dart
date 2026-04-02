import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/features/home/presentation/view/home_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PlaceOrderSuccess extends StatelessWidget {
  const PlaceOrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset(AppImages.success)),
            Gap(20),
            Text(
              "SUCCESS!".tr(),
              style: TextStyles.headline,
            ),
            Gap(10),
            Text(
              textAlign: TextAlign.center,
              "Your order will be delivered soon. Thank you for choosing our app!".tr(),
              style: TextStyles.caption1.copyWith(color: AppColors.darkGreyColor),
            ),
            Gap(20),
            MainButton(
              text: "Back To Home",
              onPressed: () {
                pushTo(context, HomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}