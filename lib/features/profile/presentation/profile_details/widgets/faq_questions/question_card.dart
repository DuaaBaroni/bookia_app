import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class QuestionCard extends StatelessWidget {
  final String questionNumber;
  final String question;
  final IconData icon;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String> onChanged;

  const QuestionCard({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.icon,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Question $questionNumber', style: TextStyles.body),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 24),
              ),
            ],
          ),
          const Gap(16),

          /// Question Text
          Text(
            question,
            style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const Gap(20),

          /// Options
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: options.map((option) {
              final isSelected = selectedValue == option;

              return SizedBox(
                width: options.length <= 3
                    ? (MediaQuery.of(context).size.width - 80) / 3 - 8
                    : (MediaQuery.of(context).size.width - 80) / 2 - 6,
                child: InkWell(
                  onTap: () => onChanged(option),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primaryColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isSelected) ...[
                          const Icon(Icons.check, color: Colors.white, size: 18),
                          const Gap(6),
                        ],
                        Flexible(
                          child: Text(
                            option,
                            textAlign: TextAlign.center,
                            style: TextStyles.body.copyWith(
                              color: isSelected
                                  ? AppColors.backgroundColor
                                  : AppColors.darkColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}