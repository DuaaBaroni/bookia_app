import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.menu_book, color: Colors.white, size: 28),
                    const Gap(8),
                    Text(
                      'Bookia',
                      style: TextStyles.title.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  'Discover Your\nNext Favorite Book',
                  style: TextStyles.caption1.copyWith(color: Colors.white),
                ),
                const Gap(12),
                Text(
                  'Answer a few questions to get\npersonalized recommendations',
                  style: TextStyles.caption1.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Icon(Icons.auto_stories, size: 120, color: Colors.white.withOpacity(0.3)),
        ],
      ),
    );
  }
}