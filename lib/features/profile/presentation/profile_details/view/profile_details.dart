import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/features/order_history/presentation/view/order_history_view.dart';
import 'package:bookia_app/features/profile/data/models/profile_details_model.dart';
import 'package:bookia_app/features/profile/presentation/change_password/view/cahnge_password.dart';
import 'package:bookia_app/features/profile/presentation/edit_profile/view/edit_profile_screen.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/widgets/contact_us/contact_us.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/widgets/faq_questions/faq_view.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/widgets/privacy_and_policy/privacy_and_policy.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: ListView.builder(
        itemCount: profileDetails.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(profileDetails[index].name, style: TextStyles.caption1),
                IconButton(
                  onPressed: () {
                    if (index == 0) {
                      pushTo(context, OrderHistoryScreen());
                    } else if (index == 1) {
                      pushTo(context, EditProfileScreen());
                    } else if (index == 2) {
                      pushTo(context, ChnagePasswordScreen());
                    } else if (index == 3) {
                      pushTo(context, BookQuestionsView());
                    } else if (index == 4) {
                      pushTo(context, ContactUsScreen());
                    } else if (index == 5) {
                      pushTo(context, PrivacyPolicyScreen());
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
