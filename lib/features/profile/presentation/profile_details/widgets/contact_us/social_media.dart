import 'package:bookia_app/features/profile/presentation/profile_details/widgets/contact_us/social_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:gap/gap.dart';

class SocialMediaCard extends StatelessWidget {
  const SocialMediaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text('Follow us on social media'.tr(), style: TextStyles.body),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialButtonContact(
                icon: Icons.facebook,
                color: Color(0xFF1877F2),
              ),
              const Gap(16),
              SocialButtonContact(
                icon: Icons.tag,
                color: Color(0xFF1DA1F2),
              ),
              const Gap(16),
              SocialButtonContact(
                icon: Icons.camera_alt,
                color: Color(0xFFE4405F),
              ),
              const Gap(16),
              SocialButtonContact(
                icon: Icons.play_arrow,
                color: Color(0xFFFF0000),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
