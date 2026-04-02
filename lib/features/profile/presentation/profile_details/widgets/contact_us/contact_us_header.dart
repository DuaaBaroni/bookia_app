import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:gap/gap.dart';

class ContactHeader extends StatelessWidget {
  const ContactHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0XFFBFA054), Color(0XFFBFA054)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(Icons.support_agent, color: Colors.white, size: 64),
          const Gap(16),
          Text('Get in Touch', style: TextStyles.title),
          const Gap(8),
          Text(
            'We\'d love to hear from you!\nSend us a message and we\'ll respond as soon as possible.'.tr(),
            textAlign: TextAlign.center,
            style: TextStyles.caption1.copyWith(
              color: AppColors.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}