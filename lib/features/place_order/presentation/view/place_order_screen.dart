import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_text_form_field.dart';
import 'package:bookia_app/core/widgets/dialogs.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/core/widgets/my_body_view.dart';
import 'package:bookia_app/features/place_order/data/models/place_order_params.dart';
import 'package:bookia_app/features/place_order/presentation/view/place_order_success.dart';
import 'package:bookia_app/features/place_order/presentation/view_model/place_order_cubit.dart';
import 'package:bookia_app/features/place_order/presentation/view_model/place_order_state.dart';
import 'package:bookia_app/features/place_order/presentation/widgets/gov_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatefulWidget {
  final String total;

  const PlaceOrderScreen({super.key, required this.total});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _governorateController = TextEditingController();
  int? _selectedGovernorateId;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _governorateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaceOrderCubit()..getGovernorates(),
      child: BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
        listener: (context, state) {
          if (state is PlaceOrderSuccessState) {
            pop(context); // Close loading dialog
            pushReplacement(context, PlaceOrderSuccess());
          }
          else if (state is PlaceOrderErrorState) {
            pop(context); // Close loading dialog
            showMyDialog(context, state.message);
          }
          else if (state is PlaceOrderLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
              ),
              automaticallyImplyLeading: false,
              title: Text('Place Order'.tr(), style: TextStyles.title),
              centerTitle: true,
            ),
            body: MyBodyView(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Place Your Order'.tr(), style: TextStyles.headline),
                      const Gap(10),
                      Text(
                        'Please fill in your delivery details to complete your order.'.tr(),
                        style: TextStyles.body.copyWith(color: Colors.grey),
                      ),
                      const Gap(28),

                      // Full Name Field
                      CustomTextFormField(
                        controller: _fullNameController,
                        hintText: 'Full Name'.tr(),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name'.tr();
                          }
                          return null;
                        },
                      ),
                      const Gap(16),

                      // Email Field
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Email'.tr(),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email'.tr();
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email'.tr();
                          }
                          return null;
                        },
                      ),
                      const Gap(16),

                      // Address Field
                      CustomTextFormField(
                        controller: _addressController,
                        hintText: 'Address'.tr(),
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address'.tr();
                          }
                          return null;
                        },
                      ),
                      const Gap(16),

                      // Phone Field
                      CustomTextFormField(
                        controller: _phoneController,
                        hintText: 'Phone'.tr(),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number'.tr();
                          }
                          return null;
                        },
                      ),
                      const Gap(16),

                      // Governorate Dropdown
                      GestureDetector(
                        onTap: () {
                          if (state is GovernoratesSuccessState) {
                            var cubit = context.read<PlaceOrderCubit>();
                            showGovernorateBottomSheet(
                              context,
                              cubit.governorates,
                              (selectedGov) {
                                setState(() {
                                  _selectedGovernorateId = selectedGov.id;
                                  _governorateController.text =
                                      selectedGov.governorateNameEn ?? '';
                                });
                              },
                            );
                          } else if (state is GovernoratesLoadingState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Loading governorates...'.tr()),
                              ),
                            );
                          } else if (state is GovernoratesErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to load governorates'.tr()),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            controller: _governorateController,
                            hintText: 'Governorate',
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a governorate'.tr();
                              }
                              return null;
                            },
                            prefixIcon: const Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),

                      const Gap(32),

                      // Total Amount
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:', style: TextStyles.subtitle1),
                            Text(
                              '\$${widget.total}',
                              style: TextStyles.subtitle1.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(24),

                      // Submit Button
                      MainButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedGovernorateId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please select a governorate'.tr()),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            final params = PlaceOrderParams(
                              name: _fullNameController.text.trim(),
                              email: _emailController.text.trim(),
                              address: _addressController.text.trim(),
                              phone: _phoneController.text.trim(),
                              governorateId: _selectedGovernorateId!,
                            );

                            context.read<PlaceOrderCubit>().placeOrder(params);
                          }
                        },
                        text: 'Submit Order'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}