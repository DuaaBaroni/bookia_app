import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/features/order_history/presentation/widget/order_card.dart';
import 'package:bookia_app/features/profile/presentation/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia_app/features/order_history/presentation/view_model/order_history_cubit.dart';
import 'package:bookia_app/features/order_history/presentation/view_model/order_history_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderHistoryCubit()..getOrderHistory(),
      child: const _OrderHistoryView(),
    );
  }
}

class _OrderHistoryView extends StatelessWidget {
  const _OrderHistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            pushTo(context, ProfileScreen());
          },
          child: SvgPicture.asset(AppImages.back),
        ),
        title: Text('My Orders', style: TextStyles.title),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
        builder: (context, state) {
          // Loading State
          if (state is OrderHistoryLoading) {
            return Center(
              child: CircularProgressIndicator(color: Color(0xFF6B4EE6)),
            );
          }

          // Error State
          if (state is OrderHistoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.grey),
                  const Gap(16),
                  Text(
                    'Failed to load orders',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrderHistoryCubit>().refresh();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6B4EE6),
                    ),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final cubit = context.read<OrderHistoryCubit>();

          // Empty State
          if (cubit.orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const Gap(16),
                  Text(
                    'No orders yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Start shopping to see your orders here',
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ],
              ),
            );
          }

          // Success State - Order List
          return RefreshIndicator(
            onRefresh: () => cubit.getOrderHistory(),
            color: Color(0xFF6B4EE6),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cubit.orders.length,
              separatorBuilder: (context, index) => const Gap(16),
              itemBuilder: (context, index) {
                final order = cubit.orders[index];
                return OrderCard(order: order);
              },
            ),
          );
        },
      ),
    );
  }
}
