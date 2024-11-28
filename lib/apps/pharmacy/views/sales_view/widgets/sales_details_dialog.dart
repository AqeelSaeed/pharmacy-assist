import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/cubits/return_cubit/return_state.dart';
import '../../../../../cubits/return_cubit/return_cubit.dart';
import '../../../../../main_barrel.dart';
import '../../return_view/widgets/return_amount_row_widget.dart';

double newTotal = 0.0;

class SalesDetailsDialog {
  void showSalesDialog(
      {required BuildContext context,
      required Sale sales,
      required List<ProductModel> productList,
      required int isReturend}) {
    log('orderId: ${sales.saleId}');

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                child: Container(
              height: MediaQuery.sizeOf(context).height * 0.8,
              width: MediaQuery.sizeOf(context).width * 0.7,
              decoration: BoxDecoration(
                  color: Palette.secondary,
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            pop(context);
                          },
                          child: Image.asset(Assets.closeIcon, height: 25),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 30),
                    child: Column(
                      children: [
                        const Text('Life Care Pharmacy',
                            style: CustomFontStyle.boldText),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichTextWidget(
                                    text1: '${name.tr()}: ',
                                    text2: sales.customerName ?? '',
                                    color2: Palette.blueColor),
                                const SizedBox(height: 10),
                                RichTextWidget(
                                    text1: '${transactionId.tr()}: ',
                                    text2: sales.saleId ?? '',
                                    color2: Palette.grey),
                                const SizedBox(height: 10),
                                RichTextWidget(
                                    text1: '${totalAmount.tr()}: ',
                                    text2: sales.totalAmount.toString(),
                                    color2: Palette.grey),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RichTextWidget(
                                    text1: '${date.tr()}: ',
                                    text2: formatDateToMonth(sales.createdAt!),
                                    color2: Palette.grey),
                                const SizedBox(height: 10),
                                RichTextWidget(
                                    text1: '${time.tr()}: ',
                                    text2:
                                        formatTime(sales.createdAt!).toString(),
                                    color2: Palette.grey),
                                const SizedBox(height: 10),
                                BlocBuilder<ReturnCubit, ReturnState>(
                                    builder: (context, state) {
                                  if (state is TotalUpdated) {
                                    return RichTextWidget(
                                        text1: 'New Total: ',
                                        text2: state.totalAmount != 0.0
                                            ? state.totalAmount
                                                .toStringAsFixed(2)
                                            : sales.totalAmount!
                                                .toStringAsFixed(2),
                                        color2: Palette.grey);
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                })
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(thickness: 0.3),
                        const ReturnAmountRowWidget(isHeading: true),
                        const SizedBox(height: 10),
                        const Divider(thickness: 0.3),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(thickness: 0.3);
                            },
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              final purchasedProducts = productList[index];
                              return ReturnAmountRowWidget(
                                  isHeading: false,
                                  srNo: (index + 1).toString(),
                                  purchasedProducts: purchasedProducts);
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<ReturnCubit, ReturnState>(
                              builder: (context, state) {
                                return ButtonComponent(
                                  onPressed: state is ReturnLoading
                                      ? null // Disable button when loading
                                      : () {
                                          List<Map<String, dynamic>>
                                              productList = context
                                                  .read<ReturnCubit>()
                                                  .returnedProducts
                                                  .map((product) =>
                                                      product.toJson())
                                                  .toList();
                                          log('apiBody: $productList');

                                          context
                                              .read<ReturnCubit>()
                                              .returnProducts(
                                                  sales.saleId ?? '',
                                                  productList)
                                              .whenComplete(() {
                                            if (context.mounted) {
                                              // Reset logic if needed
                                              // context.read<ReturnCubit>().resetNewTotal();
                                            }
                                          });
                                        },
                                  text: state is ReturnLoading
                                      ? 'Processing...'
                                      : 'Return',
                                  maxWidth: 150,
                                  height: 50,
                                );
                              },
                            ),
                            ButtonComponent(
                                onPressed: () {
                                  context
                                      .read<ReturnCubit>()
                                      .returnAllSales(sales.saleId ?? '');
                                },
                                text: 'Return All',
                                maxWidth: 150,
                                height: 50),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
          });
        });
  }
}
/*
Aqeel code
  

*/ 