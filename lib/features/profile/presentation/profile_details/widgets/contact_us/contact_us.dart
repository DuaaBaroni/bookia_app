import 'package:bookia_app/core/constants/app_images.dart';

import 'package:bookia_app/features/profile/presentation/profile_details/widgets/contact_us/contact_form.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/widgets/contact_us/contact_info.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/widgets/contact_us/contact_us_header.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/widgets/contact_us/social_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF6B4EE6),
          content: Text('Message sent successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppImages.back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              ContactHeader(),
              const Gap(24),

              // Form
              ContactForm(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                messageController: _messageController,
                onSubmit: _submitForm,
              ),
              const Gap(24),

              // Contact Info
              ContactInfoCard(),
              const Gap(24),

              // Social Media
              SocialMediaCard(),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}