import 'package:bookia_app/features/profile/presentation/profile_details/widgets/contact_us/contact_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:gap/gap.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Other ways to reach us', style: TextStyles.body),
          const Gap(20),
          ContactInfoTile(
            icon: Icons.email,
            title: 'Email',
            subtitle: 'support@bookia.com',
          ),
          const Gap(12),
          ContactInfoTile(
            icon: Icons.phone,
            title: 'Phone',
            subtitle: '+1 (555) 123-4567',
          ),
          const Gap(12),
          ContactInfoTile(
            icon: Icons.location_on,
            title: 'Address',
            subtitle: '123 Book Street, Reading City, RC 12345',
          ),
        ],
      ),
    );
  }
}
