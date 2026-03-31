import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/services/local/shared_preferences.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_svg_picture.dart';
import 'package:bookia_app/core/widgets/my_body_view.dart';
import 'package:bookia_app/features/profile/presentation/edit_profile/view/edit_profile_screen.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/view/profile_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var profileData = SharedPref.getUserInfo();
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile', style: TextStyles.title,),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: CustomSvgPicture(path: AppImages.logoutSvg),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: MyBodyView(
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: profileData?.image ?? '',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        size: 100,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Gap(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileData?.name ?? '',
                          style: TextStyles.subtitle1,
                        ),
                        Text(
                          profileData?.email ?? '',
                          style: TextStyles.body.copyWith(
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(30),
                ProfileDetails(),
            ],
          ),
        ),
      ),
    );
  }
}