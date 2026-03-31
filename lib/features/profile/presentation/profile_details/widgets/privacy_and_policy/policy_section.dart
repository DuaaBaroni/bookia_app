import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PolicySection extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;

  const PolicySection({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  State<PolicySection> createState() => _PolicySectionState();
}

class _PolicySectionState extends State<PolicySection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return 
     Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
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
          /// Header Row
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.icon, color: AppColors.primaryColor, size: 24),
                  ),
                  const Gap(16),
                  Expanded(child: Text(widget.title, style: TextStyles.body)),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),

          /// Expanded Content
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey.shade200),
                  const Gap(12),
                  Text(
                    widget.content,
                    style: TextStyles.caption2.copyWith(color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}