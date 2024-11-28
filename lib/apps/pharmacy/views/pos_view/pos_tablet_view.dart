import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/pos_view/widgets/pos_shimer_widget.dart';
import 'package:pharmacy_assist/main_barrel.dart';

import '../../../../cubits/pos_cubit/pos_state.dart';

class PosTabletView extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String query)? onChanged;
  const PosTabletView({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  @override
  State<PosTabletView> createState() => _PosTabletViewState();
}

class _PosTabletViewState extends State<PosTabletView> {
  TextEditingController searchController = TextEditingController();
  int? currentIndex; // Track the selected index
  @override
  Widget build(BuildContext context) {
    log('posTab');
    return Padding(
      padding: const EdgeInsets.fromLTRB(45, 49, 45, 0),
      child: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is PosProductList) {
                    List<ProductModel> productList = state.products;
                    final cartItemsList =
                        context.watch<POSCubit>().state.cartProducts;
                    return Padding(
                      padding: EdgeInsets.only(
                          right:
                              context.locale.languageCode == 'ar' ? 0.0 : 25.0,
                          left:
                              context.locale.languageCode == 'ar' ? 25.0 : 0.0,
                          bottom: 25),
                      child: Column(
                        children: [
                          TextFieldComponent(
                              hintText: searchPlaceholder.tr(),
                              controller: widget.controller,
                              onChanged: widget.onChanged,
                              hideBorder: true,
                              hideShadow: true,
                              prefixIconPath: Assets.searchIcon),
                          const SizedBox(
                            height: 25,
                          ),
                          Expanded(
                            child: productList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: productList.length,
                                    itemBuilder: (context, index) {
                                      return PosTileWidget(
                                        product: productList[index],
                                        cartItems: cartItemsList,
                                        onTap: () {
                                          setState(() {
                                            currentIndex =
                                                index; // Update the selected index
                                          });
                                          log('currentIndex: $index');
                                          context
                                              .read<POSCubit>()
                                              .addToCart(productList[index]);
                                        },
                                      );
                                    },
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.noProductsIcon,
                                        height: 120,
                                      ),
                                      Text(
                                        noProductsFound.tr(),
                                        textAlign: TextAlign.center,
                                        style: CustomFontStyle.boldText,
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    log('tablet_shimer');
                    return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const PosShimerWidget();
                      },
                    );
                  }
                },
              )),
              BlocBuilder<POSCubit, POSState>(
                builder: (context, state) {
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
                            child: ListView.builder(
                              itemCount: state.cartProducts.length,
                              itemBuilder: (context, index) {
                                final cartItem = state.cartProducts[index];
                                return PosCartRowWidget(
                                  isHeading: false,
                                  cartItem: cartItem,
                                  onDelete: () {
                                    context
                                        .read<POSCubit>()
                                        .removeFromCart(cartItem.id!);
                                  },
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                total.tr(),
                                style: CustomFontStyle.regularText
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '210 IQD',
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
                            onPressed: () {
                              // if (state.products.isNotEmpty) {
                              //   CheckoutDialog().showCheckoutDialog(
                              //       context, state, state.products);
                              // }
                            },
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          )
                        ]),
                      ));
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
