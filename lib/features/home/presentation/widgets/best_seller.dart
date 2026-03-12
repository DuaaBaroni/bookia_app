import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:bookia_app/features/home/presentation/view_model/home_state.dart';
import 'package:bookia_app/features/home/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BestSellerBooks extends StatelessWidget {
  const BestSellerBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccessState) {
          var books = context.read<HomeCubit>().products;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Best Sellers', style: TextStyles.title),
              Gap(30),
              GridView.builder(
                itemCount: books.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 11,
                  crossAxisSpacing: 11,
                  childAspectRatio: .6,
                ),
                itemBuilder: (context, index) {
                  return BookCard(product: books[index]);
                },
              ),
            ],
          );
        } else {
          return Column();
        }
      },
    );
  }
}
