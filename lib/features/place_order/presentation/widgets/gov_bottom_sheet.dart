import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/features/place_order/data/models/governorate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void showGovernorateBottomSheet(
  BuildContext context,
  List<Governorate> governorates,
  Function(Governorate) onSelected,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,  
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Gap(16),
            
            // Title
            Text('Select Governorate'.tr(), style: TextStyles.title),
            const Divider(),
            const Gap(8),
            
            // List
            Expanded(  
              child: ListView.separated(
                itemCount: governorates.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final governorate = governorates[index];
                  return ListTile(
                    title: Text(
                      governorate.governorateNameEn ?? '',
                      style: TextStyles.body,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      onSelected(governorate);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}