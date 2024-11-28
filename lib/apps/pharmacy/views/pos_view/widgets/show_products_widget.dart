import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/pos_view/widgets/pos_shimer_widget.dart';

import 'package:pharmacy_assist/main_barrel.dart';

class ShowProductsWidget extends StatefulWidget {
  final Function(String query)? onChanged;
  final TextEditingController controller;
  const ShowProductsWidget(
      {super.key, required this.controller, required this.onChanged});

  @override
  State<ShowProductsWidget> createState() => _ShowProductsWidgetState();
}

class _ShowProductsWidgetState extends State<ShowProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is PosProductList) {
          List<ProductModel> productList = state.products;
          final cartItemsList = context.watch<POSCubit>().state.cartProducts;
          return Padding(
            padding: EdgeInsets.only(
                right: context.locale.languageCode == 'ar' ? 0.0 : 25.0,
                left: context.locale.languageCode == 'ar' ? 25.0 : 0.0,
                bottom: 25),
            child: Column(
              children: [
                TextFieldComponent(
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    hintText: searchPlaceholder.tr(),
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
                                context
                                    .read<POSCubit>()
                                    .addToCart(productList[index]);
                                log('cartItemsList: ${productList[index].productName}');
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
                              style: CustomFontStyle.boldText,
                            ),
                          ],
                        ),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const PosShimerWidget();
            },
          );
        }
      },
    ));
  }
}
