import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/features/profile/presentation/profile/view/profile_screen.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/widgets/privacy_and_policy/policy_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  final List<Map<String, dynamic>> _sections = const [
    {
      "icon": Icons.info_outline,
      "title": "1. Information We Collect",
      "content":
          "We collect information you provide directly to us, including:\n\n"
          "• Account information (name, email, password)\n"
          "• Profile information (reading preferences, favorite genres)\n"
          "• Reading history and book reviews\n"
          "• Payment information for purchases\n"
          "• Device information and usage data",
    },
    {
      "icon": Icons.security,
      "title": "2. How We Use Your Information",
      "content":
          "We use the information we collect to:\n\n"
          "• Provide and improve our services\n"
          "• Personalize your book recommendations\n"
          "• Process your transactions\n"
          "• Send you updates and promotional content\n"
          "• Analyze usage patterns and trends\n"
          "• Ensure security and prevent fraud",
    },
    {
      "icon": Icons.share,
      "title": "3. Information Sharing",
      "content":
          "We may share your information with:\n\n"
          "• Service providers who assist us in operations\n"
          "• Publishers and authors (aggregated data only)\n"
          "• Law enforcement when required by law\n"
          "• Other users (only public profile information)\n\n"
          "We never sell your personal information to third parties.",
    },
    {
      "icon": Icons.cookie,
      "title": "4. Cookies and Tracking",
      "content":
          "We use cookies and similar technologies to:\n\n"
          "• Remember your preferences\n"
          "• Understand how you use our app\n"
          "• Provide personalized content\n"
          "• Improve our services\n\n"
          "You can control cookies through your browser settings.",
    },
    {
      "icon": Icons.lock,
      "title": "5. Data Security",
      "content":
          "We implement industry-standard security measures:\n\n"
          "• Encryption of sensitive data\n"
          "• Secure server infrastructure\n"
          "• Regular security audits\n"
          "• Access controls and authentication\n"
          "• Secure payment processing\n\n"
          "However, no method of transmission is 100% secure.",
    },
    {
      "icon": Icons.person,
      "title": "6. Your Rights",
      "content":
          "You have the right to:\n\n"
          "• Access your personal data\n"
          "• Correct inaccurate information\n"
          "• Request deletion of your data\n"
          "• Opt-out of marketing communications\n"
          "• Export your data\n"
          "• Withdraw consent at any time",
    },
    {
      "icon": Icons.child_care,
      "title": "7. Children's Privacy",
      "content":
          "Our service is not intended for children under 13.\n\n"
          "We do not knowingly collect information from children. "
          "If you believe we have collected information from a child, "
          "please contact us immediately and we will delete it.",
    },
    {
      "icon": Icons.update,
      "title": "8. Changes to This Policy",
      "content":
          "We may update this Privacy Policy from time to time.\n\n"
          "We will notify you of any changes by:\n"
          "• Posting the new policy on this page\n"
          "• Updating the \"Last updated\" date\n"
          "• Sending you an email notification (for major changes)\n\n"
          "Your continued use constitutes acceptance of changes.",
    },
    {
      "icon": Icons.email,
      "title": "9. Contact Us",
      "content":
          "If you have questions about this Privacy Policy:\n\n"
          "📧 Email: privacy@bookia.com\n"
          "📞 Phone: +1 (555) 123-4567\n"
          "📍 Address: 123 Book Street, Reading City, RC 12345\n\n"
          "We will respond to your inquiry within 48 hours.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => pushTo(context, const ProfileScreen()),
          child: SvgPicture.asset(AppImages.back), // SVG Back Icon
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ..._sections.map(
              (section) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PolicySection(
                  icon: section["icon"],
                  title: section["title"],
                  content: section["content"],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
