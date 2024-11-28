import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/cubits/pos_cubit/pos_state.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import '../../../../utils/shared_pref.dart';
import 'widgets/show_products_widget.dart';

class PosDesktopView extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String query)? onChanged;
  const PosDesktopView({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  @override
  State<PosDesktopView> createState() => _PosDesktopViewState();
}

class _PosDesktopViewState extends State<PosDesktopView> {
  TextEditingController customerNameController = TextEditingController();

  int? currentIndex;
  int? cartItemIndex;

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    log('posDesktop');
    return Padding(
      padding: const EdgeInsets.fromLTRB(45, 49, 45, 0),
      child: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              ShowProductsWidget(
                controller: widget.controller!,
                onChanged: widget.onChanged,
              ),
              BlocConsumer<POSCubit, POSState>(listener: (context, state) {
                if (state is Checkedout) {
                  context
                      .read<ProductCubit>()
                      .fetchProducts(SharedPref.getString(key: 'uid'));
                  context.read<POSCubit>().clearCart();
                  alert(context, state.successMessage, info: true, onTap: () {
                    Navigator.pop(context);
                  });
                } else if (state is CheckoutError) {
                  alert(context, state.errorMessage, info: false, onTap: () {
                    Navigator.pop(context);
                  });
                }
              }, builder: (context, state) {
                final posState = state;
                final cartItemsList =
                    context.watch<POSCubit>().state.cartProducts;

                return Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      margin: const EdgeInsets.only(bottom: 25),
                      decoration: BoxDecoration(
                          color: Palette.secondary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.cartIcon,
                              height: 35,
                              width: 35,
                              color: Palette.black,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              cartItems.tr(),
                              style: CustomFontStyle.regularText.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Palette.black),
                            ),
                            const Spacer(),
                            ButtonComponent(
                              text: clearCart.tr(),
                              backgroundColor: Palette.black,
                              maxWidth: 160,
                              onPressed: () {
                                context.read<POSCubit>().clearCart();
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          thickness: 0.3,
                          height: 0.3,
                          color: Palette.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const PosCartRowWidget(
                          isHeading: true,
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(thickness: 0.3, height: 0.3);
                            },
                            itemCount: cartItemsList.length,
                            itemBuilder: (context, index) {
                              final cartItem = cartItemsList[index];
                              cartItemIndex = index;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: PosCartRowWidget(
                                    isHeading: false,
                                    srNo: (index + 1).toString(),
                                    cartItem: cartItem,
                                    onDelete: () {
                                      context
                                          .read<POSCubit>()
                                          .removeFromCart(cartItem.id!);
                                    }),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          thickness: 0.3,
                          height: 0.3,
                          color: Palette.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 55,
                              width: 300,
                              child: TextFieldComponent(
                                hintText: customerName.tr(),
                                controller: customerNameController,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${total.tr()}: ',
                              style: CustomFontStyle.regularText
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${state.totalAmount.toStringAsFixed(2)} IQD',
                              style: CustomFontStyle.regularText
                                  .copyWith(color: Palette.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonComponent(
                          text: checkout.tr(),
                          isLoading: state is CheckingOut,
                          onPressed: () {
                            if (cartItemsList.isEmpty) {
                              return;
                            }
                            final invalidItemIndex = cartItemsList
                                .indexWhere((item) => (item.boxQuantity == 0));

                            if (invalidItemIndex != -1) {
                              final invalidItem =
                                  cartItemsList[invalidItemIndex];
                              log('Invalid item at index: $invalidItemIndex');
                              snack(context,
                                  'Missing Box Quantity for ${invalidItem.productName}',
                                  info: false);
                              return;
                            }
                            if (customerNameController.text.isEmpty) {
                              alert(context, customerNameRequired.tr(),
                                  info: false);
                              return;
                            }

                            context.read<POSCubit>().checkout(
                                customerName: customerNameController.text,
                                list: cartItemsList,
                                totalAmount: posState.totalAmount);
                          },
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        )
                      ]),
                    ));
              })
            ],
          ))
        ],
      ),
    );
  }
}
